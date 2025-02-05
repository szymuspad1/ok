<?php

namespace App\Http\Controllers;

use App\Constants\ManageStatus;
use App\Models\Advertisement;
use App\Models\Category;
use App\Models\Company;
use App\Models\Contact;
use App\Models\Language;
use App\Models\Review;
use App\Models\SiteData;
use App\Models\Subscriber;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\Validator;

class WebsiteController extends Controller
{   
    function home() {
        $pageTitle     = 'Home';
        $categories    = Category::active()->latest()->get();
        $companies     = Company::activeCheck()->latest()->limit(15)->get();
        $reviews       = Review::with(['company', 'user'])->latest()->take(6)->get();
        $topCategories = Category::active()->highlight()->latest()->limit(8)->get();

        return view($this->activeTheme . 'page.home', compact('pageTitle', 'categories', 'companies', 'reviews', 'topCategories'));
    }

    function changeLanguage($lang = null) {
        $language = Language::where('code', $lang)->first();

        if (!$language) $lang = 'en';
        session()->put('lang', $lang);
        return back();
    }

    function cookieAccept() {
        Cookie::queue('gdpr_cookie', bs('site_name'), 43200);
    }

    function cookiePolicy() {
        $pageTitle = 'Cookie Policy';
        $subTitle  = 'Understanding Cookies – Your Privacy, Our Priority.';
        $cookie    = SiteData::where('data_key', 'cookie.data')->first();

        return view($this->activeTheme . 'page.cookie',compact('pageTitle', 'subTitle', 'cookie'));
    }

    function maintenance() {
        if(bs('site_maintenance') == ManageStatus::INACTIVE) {
            return to_route('home');
        }

        $maintenance = SiteData::where('data_key', 'maintenance.data')->first();
        $pageTitle   = $maintenance->data_info->heading;
        $subTitle    = 'Keeping Things Fresh and Updated – Site Under Maintenance';

        return view($this->activeTheme . 'page.maintenance', compact('pageTitle', 'subTitle', 'maintenance'));
    }

    public function policyPages($slug,$id) {
        $policy    = SiteData::where('id', $id)->where('data_key', 'policy_pages.element')->firstOrFail();
        $pageTitle = $policy->data_info->title;

        return view($this->activeTheme . 'page.policy', compact('policy', 'pageTitle'));
    }

    function contact() {
        $pageTitle      = 'Get in Touch';
        $subTitle       = 'Connect with Us for Assistance and Inquiries';
        $user           = auth()->user();
        $contactContent = SiteData::where('data_key', 'contact_us.content')->firstOrFail();

        return view($this->activeTheme . 'page.contact', compact('pageTitle', 'user', 'subTitle', 'contactContent'));
    }

    function contactStore() {
        $this->validate(request(), [
            'name'    => 'required|string|max:40',
            'email'   => 'required|string|max:40',
            'subject' => 'required|string|max:255',
            'message' => 'required',
        ]);

        if(!verifyCaptcha()) {
            $toast[] = ['error', 'Invalid captcha provided'];
            return back()->withToasts($toast);
        }

        $user         = auth()->user();
        $email        = $user ? $user->email : request('email');
        $contactCheck = Contact::where('email', $email)->where('status', ManageStatus::NO)->first();

        if ($contactCheck) {
            $toast[] = ['warning', 'There is an existing contact on record, kindly await the admin\'s response'];
            return back()->withToasts($toast);
        }

        $contact          = new Contact();
        $contact->name    = $user ? $user->fullname : request('name');
        $contact->email   = $email;
        $contact->subject = request('subject');
        $contact->message = request('message');
        $contact->save();
        
        $toast[] = ['success', 'We register this contact in our record, kindly await the admin\'s response'];
        return back()->withToasts($toast);
    }

    function searchByCategory($name, $id) {
        $category   = Category::active()->find($id);

        if(!$category) {
            $toast[] = ['error', 'Category not found or disabled'];
            return back()->withToasts($toast);
        }

        $companies  = Company::activeCheck()->where('category_id', $id)->with(['user', 'category'])->latest()->paginate(getPaginate(8));
        $pageTitle  = 'Result for - '. $category->short_name;
        $subTitle   = 'Explore top-rated businesses with reviews to guide your choices.';
        $categories = Category::active()->orderBy('name')->companyCount()->get();

        return view($this->activeTheme . 'company.companies', compact('pageTitle', 'subTitle', 'companies', 'categories'));
    }

    function searchByTag($name) {;
        $companies  = Company::activeCheck()->whereJsonContains('tags', $name)->with(['user', 'category'])->latest()->paginate(getPaginate(8));
        $pageTitle  = 'Result for - '. $name;
        $subTitle   = 'Explore top-rated businesses with reviews to guide your choices.';
        $categories = Category::active()->orderBy('name')->companyCount()->get();

        return view($this->activeTheme . 'company.companies', compact('pageTitle', 'subTitle', 'companies', 'categories'));
    }

    function companies() {
        $pageTitle  = 'Companies';
        $subTitle   = 'Explore top-rated businesses with reviews to guide your choices.';
        $categories = Category::active()->orderBy('name')->companyCount()->get();
        $companies  = Company::activeCheck();
        
        if (request()->ajax()) {
            $validate = Validator::make(request()->all(), [
                'categories'    => 'nullable|array',
                'categories.*'  => 'nullable|int|gte:0',
                'rating'        => 'nullable|in:0,1,2,3,4,5',
                'review_time'   => 'nullable|in:0,1,2,3,6,12',
                'joining_start' => 'nullable|int',
                'joining_end'   => 'nullable|int'
            ]);
    
            if($validate->fails()) {
                return response()->json(['error' => $validate->errors()]);
            }

            $requestedSearchKey    = request('search');
            $requestedCategories   = request('categories');
            $requestedrating       = request('rating');
            $requestedReviewTime   = request('review_time');
            $requesteDJoiningStart = request('joining_start');
            $requesteDJoiningEnd   = request('joining_end');

            if ($requestedSearchKey) {
                $companies = $companies->where('name', 'LIKE', "%$requestedSearchKey%")->orWhereJsonContains('tags', $requestedSearchKey);
            }

            if (!empty($requestedCategories) && !(in_array(0, $requestedCategories))) {
                $companies = $companies->whereIn('category_id', $requestedCategories);
            }

            if ($requestedrating) {
                $requestedrating = intval($requestedrating);
                $companies = $companies->whereBetween('avg_rating', [$requestedrating - 1 + .1, $requestedrating]);
            }

            if ($requestedReviewTime) {
                $startMonth = now()->subMonths($requestedReviewTime);
                $endMonth =  now();

                $companies = $companies->whereHas('reviews', function ($q) use ($startMonth, $endMonth) {
                    $q->whereBetween('created_at', [$startMonth, $endMonth]);
                });
            }

            if ($requesteDJoiningStart && $requesteDJoiningEnd) {
                $start = now()->subYear($requesteDJoiningEnd);
                $end   = now()->subYear($requesteDJoiningStart);
                $companies = $companies->whereBetween('created_at', [$start, $end]);
            } elseif ($requesteDJoiningEnd) {
                $start = now()->subYear($requesteDJoiningEnd);
                $end   = now();
                $companies = $companies->whereBetween('created_at', [$start, $end]);
            } elseif ($requesteDJoiningStart) {
                $year = now()->subYear($requesteDJoiningStart);
                $companies = $companies->whereDate('created_at', '<', $year);
            } else {
                $companies = $companies;
            }

            $companies = $companies->with(['user', 'category'])->latest()->paginate(getPaginate(8));
            $html      = view($this->activeTheme . 'company.ajax', compact('companies'))->render();

            return response()->json(
                [
                    'success'  => true,
                    'html'     => $html
                ]
            );
        } else {
            $companies = $companies->with(['user', 'category'])->latest()->paginate(getPaginate(8));
        }
    
        return view($this->activeTheme . 'company.companies', compact('pageTitle', 'subTitle', 'companies', 'categories'));
    }

    function companyDetails($name, $id) {
        $company = Company::activeCheck()->find($id);

        if(!$company) {
            $toast[] = ['error', 'Company not found or disabled'];
            return back()->withToasts($toast);
        }

        $pageTitle      = 'Company Details';
        $subTitle       = 'Explore Your Company Specifications';
        $existedReview  = null;
        
        if (auth()->check()) {
            $existedReview  = Review::where('user_id', auth()->id())->where('company_id', $company->id)->first();
        }

        $reviews        = Review::where('company_id', $company->id)->with(['user'])->latest()->paginate(getPaginate());
        $companyContent = getSiteData('company_details.content', true);

        // Rating Calculation
        $totalReviewer  = $company->total_reviewer;

        if (!$totalReviewer) {
            $totalReviewer = 1;
        }

        $query = Review::where('company_id', $id);
        
        $percentage = [
            'singleStar' => (clone $query)->where('rating', ManageStatus::SINGLE_STAR)->count() / $totalReviewer * 100,
            'doubleStar' => (clone $query)->where('rating', ManageStatus::DOUBLE_STAR)->count() / $totalReviewer * 100,
            'tripleStar' => (clone $query)->where('rating', ManageStatus::TRIPLE_STAR)->count() / $totalReviewer * 100,
            'quadStar'   => (clone $query)->where('rating', ManageStatus::QUAD_STAR)->count() / $totalReviewer * 100,
            'fiveStar'   => (clone $query)->where('rating', ManageStatus::FIVE_STAR)->count() / $totalReviewer * 100
        ];

        return view($this->activeTheme . 'company.companyDetails', compact('pageTitle', 'subTitle', 'company', 'companyContent', 'existedReview', 'reviews', 'percentage'));
    }

    function blogs() {
        $pageTitle = 'Blogs';
        $subTitle  = 'Stay updated on business trends, expert tips, and industry insights to help you grow';
        $blogs     = SiteData::where('data_key', 'blog.element')->latest()->paginate(getPaginate(9));


        return view($this->activeTheme . 'page.blog', compact('pageTitle', 'subTitle', 'blogs'));
    }

    function blogDetail($name, $blogId) {
        $pageTitle = 'Blog Details';
        $subTitle  = 'Explore industry trends, expert insights, and tips to help your business thrive';
        $blog      = SiteData::where('id', $blogId)->where('data_key', 'blog.element')->firstOrFail();
        $blogs     = SiteData::where('id', '!=', $blogId)->where('data_key', 'blog.element')->limit(6)->get();

        $seoContents['keywords']           = $blog->data_info->meta_keywords ?? [];
        $seoContents['social_title']       = $blog->data_info->title;
        $seoContents['description']        = strLimit($blog->data_info->description, 150);
        $seoContents['social_description'] = strLimit($blog->data_info->description,150);
        $imageSize                         = '795x500';
        $seoContents['image']              = getImage(activeTheme(true) . 'images/site/blog/' . @$blog->data_info->blog_image_1, $imageSize);
        $seoContents['image_size']         = $imageSize;


        return view($this->activeTheme . 'page.blogDetail', compact('blog', 'pageTitle', 'subTitle', 'blogs', 'seoContents'));
    }

    function reviews() {
        $pageTitle = 'Reviews';
        $subTitle  = 'Discover real customer insights to make informed choices';
        $reviews   = Review::with(['company', 'user'])->latest()->paginate(getPaginate(11));

        return view($this->activeTheme . 'page.review', compact('pageTitle', 'subTitle', 'reviews'));
    }

    function subscribe() {
        $validate = Validator::make(request()->all(), [
            'email' => 'required|email|unique:subscribers,email'
        ]);

        if($validate->fails()) {
            return response()->json(['error' => $validate->errors()]);
        }

        $subscriber = new Subscriber();
        $subscriber->email = request('email');
        $subscriber->save();

        return response()->json(['success' => 'Subscription successfull']);
    }

    function addClick($id) {
        $advertisement = Advertisement::find($id);

        if ($advertisement) {
            $advertisement->click += 1;
            $advertisement->save();
        }

        return response()->json([
            'success' => true,
            'data'    => $advertisement
        ]);
    }

    function placeholderImage($size = null) {
        $imgWidth = explode('x',$size)[0];
        $imgHeight = explode('x',$size)[1];
        $text = $imgWidth . '×' . $imgHeight;
        $fontFile = realpath('assets/font/RobotoMono-Regular.ttf');
        $fontSize = round(($imgWidth - 50) / 8);

        if ($fontSize <= 9) {
            $fontSize = 9;
        }

        if($imgHeight < 100 && $fontSize > 30){
            $fontSize = 30;
        }

        $image     = imagecreatetruecolor($imgWidth, $imgHeight);
        $colorFill = imagecolorallocate($image, 100, 100, 100);
        $bgFill    = imagecolorallocate($image, 175, 175, 175);
        imagefill($image, 0, 0, $bgFill);
        $textBox = imagettfbbox($fontSize, 0, $fontFile, $text);
        $textWidth  = abs($textBox[4] - $textBox[0]);
        $textHeight = abs($textBox[5] - $textBox[1]);
        $textX      = ($imgWidth - $textWidth) / 2;
        $textY      = ($imgHeight + $textHeight) / 2;
        header('Content-Type: image/jpeg');
        imagettftext($image, $fontSize, 0, $textX, $textY, $colorFill, $fontFile, $text);
        imagejpeg($image);
        imagedestroy($image);
    }
}
