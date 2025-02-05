-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 08, 2025 at 12:55 PM
-- Server version: 8.0.30
-- PHP Version: 8.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `username`, `contact`, `address`, `email_verified_at`, `image`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Mr Admin', 'admin@test.com', 'admin', '123456789', '477 Jalan Kelapa Hijau Segambut Bahagia', NULL, '677e67d0e5db41736337360.png', '$2y$12$ZGhZSJpa/CtjT6omKsFKr.HrsKBCE7EhfQx8JrPRrO6OrKvBdYqRS', NULL, NULL, '2025-01-08 11:56:00');

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `click_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_password_resets`
--

CREATE TABLE `admin_password_resets` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `advertisements`
--

CREATE TABLE `advertisements` (
  `id` bigint UNSIGNED NOT NULL,
  `type` tinyint UNSIGNED NOT NULL COMMENT '1 -> Image, 2-> Script',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `script` text COLLATE utf8mb4_unicode_ci,
  `size` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `impression` int UNSIGNED NOT NULL DEFAULT '0',
  `click` int UNSIGNED NOT NULL DEFAULT '0',
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `highlight` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `category_id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `details` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '2',
  `avg_rating` float(5,2) NOT NULL DEFAULT '0.00',
  `admin_feedback` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `total_rating` int UNSIGNED DEFAULT '0',
  `total_reviewer` int UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '1:Answered, 0:Unanswered',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `id` bigint UNSIGNED NOT NULL,
  `act` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `forms`
--

INSERT INTO `forms` (`id`, `act`, `form_data`, `created_at`, `updated_at`) VALUES
(1, 'company_verification', '{}', '2023-09-29 00:40:47', '2025-01-01 10:43:37'),
(3, 'kyc', '{}', '2023-10-09 06:58:42', '2024-06-09 10:25:25');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `status`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', 1, NULL, '2024-06-03 20:13:50'),
(7, 'Arabic', 'ar', 1, '2024-06-03 20:37:55', '2025-01-08 07:46:57'),
(8, 'Portuguese', 'pr', 1, '2024-06-08 13:16:23', '2024-06-08 13:16:23'),
(9, 'French', 'fr', 1, '2024-06-08 13:17:21', '2024-06-08 13:17:21');

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` bigint UNSIGNED NOT NULL,
  `act` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subj` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sms_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `shortcodes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `email_status` tinyint(1) NOT NULL DEFAULT '1',
  `sms_status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `act`, `name`, `subj`, `email_body`, `sms_body`, `shortcodes`, `email_status`, `sms_status`, `created_at`, `updated_at`) VALUES
(7, 'PASS_RESET_CODE', 'Password - Reset - Code', 'Password Reset', '<div style=\"font-family: Montserrat, sans-serif;\">We have received a request to reset the password for your account on&nbsp;<span style=\"font-weight: bolder;\">{{time}} .<br></span></div><div style=\"font-family: Montserrat, sans-serif;\">Requested From IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><br style=\"font-family: Montserrat, sans-serif;\"><div style=\"font-family: Montserrat, sans-serif;\"><div>Your account recovery code is:&nbsp;&nbsp;&nbsp;<font size=\"6\"><span style=\"font-weight: bolder;\">{{code}}</span></font></div><div><br></div></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\" color=\"#CC0000\">If you do not wish to reset your password, please disregard this message.&nbsp;</font><br></div><div><font size=\"4\" color=\"#CC0000\"><br></font></div>', 'Your account recovery code is: {{code}}', '{\"code\":\"Verification code for password reset\",\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, 0, '2021-11-03 12:00:00', '2022-03-20 20:47:05'),
(8, 'PASS_RESET_DONE', 'Password - Reset - Confirmation', 'You have reset your password', '<p style=\"font-family: Montserrat, sans-serif;\">You have successfully reset your password.</p><p style=\"font-family: Montserrat, sans-serif;\">You changed from&nbsp; IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{time}}</span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><font color=\"#ff0000\">If you did not change that, please contact us as soon as possible.</font></span></p>', 'Your password has been changed successfully', '{\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, 1, '2021-11-03 12:00:00', '2022-04-05 03:46:35'),
(10, 'EVER_CODE', 'Verification - Email', 'Please verify your email address', '<br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;{{code}}</span></font></div></div>', '---', '{\"code\":\"Email verification code\"}', 1, 0, '2021-11-03 12:00:00', '2022-04-03 02:32:07'),
(11, 'SVER_CODE', 'Verification - SMS', 'Verify Your Mobile Number', '---', 'Your phone verification code is: {{code}}', '{\"code\":\"SMS Verification Code\"}', 0, 1, '2021-11-03 12:00:00', '2022-03-20 19:24:37'),
(15, 'DEFAULT', 'Default Template', '{{subject}}', '{{message}}', '{{message}}', '{\"subject\":\"Subject\",\"message\":\"Message\"}', 1, 1, '2019-09-14 13:14:22', '2021-11-04 09:38:55'),
(16, 'KYC_APPROVE', 'KYC Approved', 'KYC has been approved', NULL, NULL, '[]', 1, 1, NULL, NULL),
(17, 'KYC_REJECT', 'KYC Rejected Successfully', 'KYC has been rejected', NULL, NULL, '[]', 1, 1, NULL, NULL),
(18, 'DELETE_REVIEW', 'Delete Review', 'Notice of Review Deletion', '<p>We wanted to inform you that your recent review &nbsp;<strong>{{company_name}}</strong> has been removed. After reviewing the report , we found it to be valid and consistent with our guidelines.&nbsp;</p><p>&nbsp;</p><p>If you have any questions, feel free to contact our support team. Thank you for your understanding.</p>', 'We wanted to inform you that your recent review  {{company_name}} has been removed. After reviewing the report , we found it to be valid and consistent with our guidelines.', '{\"company_name\": \"The company name\"}', 1, 1, '2021-11-03 12:00:00', '2025-01-05 11:09:06'),
(19, 'DELETE_REPORT', 'Delete Report', 'Notice of Report Deletion', '<p>Dear {{reporter_name}}, After careful review, we have determined that your report regarding the review on {{company_name}} does not meet our criteria for removal. As a result, your report has been dismissed, and the review will remain on our platform. If you have further questions, please feel free to reach out to our support team. Thank you for your understanding.</p>', 'Dear {{reporter_name}}, After careful review, we have determined that your report regarding the review on {{company_name}} does not meet our criteria for removal. As a result, your report has been dismissed, and the review will remain on our platform. If you have further questions, please feel free to reach out to our support team. Thank you for your understanding.', '{\"company_name\": \"The company name\", \n\"reporter_name\": \"Who reported against the review\"}', 1, 1, '2021-11-03 12:00:00', '2025-01-05 11:53:57'),
(20, 'INFORM_REPORTER', 'Inform Reporter', 'Report Validated – Review Removed', '<p>We have reviewed your report concerning a review on {{company_name}} and found it to be valid. As a result, the review has been removed from our platform. Thank you for helping us maintain a trustworthy environment. If you have any further concerns, please don’t hesitate to reach out.&nbsp;</p>', 'We have reviewed your report concerning a review on {{company_name}} and found it to be valid. As a result, the review has been removed from our platform. Thank you for helping us maintain a trustworthy environment. If you have any further concerns, please don’t hesitate to reach out.', '{\"company_name\": \"The company name\"}', 1, 1, '2021-11-03 12:00:00', '2025-01-05 11:45:11'),
(21, 'DELETE_REPORTED_REVIEW', 'Delete Reported Review', 'Notice of Reported Review Deletion', '<p>We wanted to inform you that your recent review on {{company_name}} has been removed. After reviewing the report submitted by the company, we found it to be valid and consistent with our guidelines.&nbsp;</p><p>&nbsp;</p><p>If you have any questions, feel free to contact our support team. Thank you for your understanding.&nbsp;</p>', 'We wanted to inform you that your recent review on {{company_name}} has been removed. After reviewing the report submitted by the company, we found it to be valid and consistent with our guidelines.', '{\"company_name\": \"The company name\"}', 1, 1, '2021-11-03 12:00:00', '2025-01-05 11:11:40');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plugins`
--

CREATE TABLE `plugins` (
  `id` bigint UNSIGNED NOT NULL,
  `act` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `script` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `shortcode` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'object',
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plugins`
--

INSERT INTO `plugins` (`id`, `act`, `name`, `image`, `script`, `shortcode`, `status`, `created_at`, `updated_at`) VALUES
(1, 'google-analytics', 'Google Analytics', 'analytics.png', '<script async src=\"https://www.googletagmanager.com/gtag/js?id={{app_key}}\"></script>\n                <script>\n                  window.dataLayer = window.dataLayer || [];\n                  function gtag(){dataLayer.push(arguments);}\n                  gtag(\"js\", new Date());\n                \n                  gtag(\"config\", \"{{app_key}}\");\n                </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"-----------------\"}}', 0, NULL, '2025-01-08 12:37:43'),
(2, 'google-recaptcha2', 'Google Recaptcha 2', 'captcha.png', '\n<script src=\"https://www.google.com/recaptcha/api.js\"></script>\n<div class=\"g-recaptcha\" data-sitekey=\"{{site_key}}\" data-callback=\"verifyCaptcha\"></div>\n<div id=\"g-recaptcha-error\"></div>', '{\"site_key\":{\"title\":\"Site Key\",\"value\":\"-----------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"value\":\"-----------------\"}}', 0, NULL, '2025-01-08 12:37:50'),
(3, 'facebook-messenger', 'Facebook Messenger', 'messenger.png', '<div id=\"fb-root\"></div>\n<div id=\"fb-customer-chat\" class=\"fb-customerchat\"></div>\n\n<script>\n    var chatbox = document.getElementById(\'fb-customer-chat\');\n    chatbox.setAttribute(\"page_id\", {{page_id}});\n    chatbox.setAttribute(\"attribution\", \"biz_inbox\");\n</script>\n\n<!-- Your SDK code -->\n<script>\n    window.fbAsyncInit = function() {\n    FB.init({\n        xfbml            : true,\n        version          : \'v17.0\'\n    });\n    };\n\n    (function(d, s, id) {\n    var js, fjs = d.getElementsByTagName(s)[0];\n    if (d.getElementById(id)) return;\n    js = d.createElement(s); js.id = id;\n    js.src = \'https://connect.facebook.net/en_US/sdk/xfbml.customerchat.js\';\n    fjs.parentNode.insertBefore(js, fjs);\n    }(document, \'script\', \'facebook-jssdk\'));\n</script>', '{\"page_id\":{\"title\":\"Page Id\",\"value\":\"-----------------\"}}', 0, NULL, '2025-01-08 12:37:38'),
(4, 'tawk-chat', 'Tawk.to', 'tawk.png', '<script>\n                        var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();\n                        (function(){\n                        var s1=document.createElement(\"script\"),s0=document.getElementsByTagName(\"script\")[0];\n                        s1.async=true;\n                        s1.src=\"https://embed.tawk.to/{{app_key}}\";\n                        s1.charset=\"UTF-8\";\n                        s1.setAttribute(\"crossorigin\",\"*\");\n                        s0.parentNode.insertBefore(s1,s0);\n                        })();\n                    </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"-----------------\"}}', 0, NULL, '2025-01-08 12:37:55');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `review_id` int UNSIGNED NOT NULL,
  `user_feedback` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `company_id` int UNSIGNED NOT NULL,
  `rating` int UNSIGNED NOT NULL,
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `report_status` tinyint(1) NOT NULL DEFAULT '0',
  `report_id` int UNSIGNED NOT NULL DEFAULT '0',
  `reporter_id` int UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `site_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_cur` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'site currency text',
  `cur_sym` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'site currency symbol',
  `per_page_item` int UNSIGNED NOT NULL DEFAULT '20',
  `date_format` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MDY',
  `fraction_digit` tinyint UNSIGNED NOT NULL DEFAULT '2',
  `email_from` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_template` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sms_body` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_from` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sms_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `universal_shortcodes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `first_color` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `second_color` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signup` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'user registration',
  `enforce_ssl` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'enforce ssl',
  `agree_policy` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'accept terms and policy',
  `strong_pass` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'enforce strong password',
  `kc` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'kyc confirmation',
  `ec` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'email confirmation',
  `ea` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'email alert',
  `sc` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'sms confirmation',
  `sa` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'sms alert',
  `site_maintenance` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `language` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `active_theme` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'primary',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `site_name`, `site_cur`, `cur_sym`, `per_page_item`, `date_format`, `fraction_digit`, `email_from`, `email_template`, `sms_body`, `sms_from`, `mail_config`, `sms_config`, `universal_shortcodes`, `first_color`, `second_color`, `signup`, `enforce_ssl`, `agree_policy`, `strong_pass`, `kc`, `ec`, `ea`, `sc`, `sa`, `site_maintenance`, `language`, `active_theme`, `created_at`, `updated_at`) VALUES
(1, 'TonaRate', 'USD', '$', 20, 'Y-m-d', 2, 'info@tonatheme.com', '<title></title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n<style type=\"text/css\">\r\n    @media screen {\r\n		@font-face {\r\n		  font-family: \'Lato\';\r\n		  font-style: normal;\r\n		  font-weight: 400;\r\n		  src: local(\'Lato Regular\'), local(\'Lato-Regular\'), url(https://fonts.gstatic.com/s/lato/v11/qIIYRU-oROkIk8vfvxw6QvesZW2xOQ-xsNqO47m55DA.woff) format(\'woff\');\r\n		}\r\n		\r\n		@font-face {\r\n		  font-family: \'Lato\';\r\n		  font-style: normal;\r\n		  font-weight: 700;\r\n		  src: local(\'Lato Bold\'), local(\'Lato-Bold\'), url(https://fonts.gstatic.com/s/lato/v11/qdgUG4U09HnJwhYI-uK18wLUuEpTyoUstqEm5AMlJo4.woff) format(\'woff\');\r\n		}\r\n		\r\n		@font-face {\r\n		  font-family: \'Lato\';\r\n		  font-style: italic;\r\n		  font-weight: 400;\r\n		  src: local(\'Lato Italic\'), local(\'Lato-Italic\'), url(https://fonts.gstatic.com/s/lato/v11/RYyZNoeFgb0l7W3Vu1aSWOvvDin1pK8aKteLpeZ5c0A.woff) format(\'woff\');\r\n		}\r\n		\r\n		@font-face {\r\n		  font-family: \'Lato\';\r\n		  font-style: italic;\r\n		  font-weight: 700;\r\n		  src: local(\'Lato Bold Italic\'), local(\'Lato-BoldItalic\'), url(https://fonts.gstatic.com/s/lato/v11/HkF_qI1x_noxlxhrhMQYELO3LdcAZYWl9Si6vvxL-qU.woff) format(\'woff\');\r\n		}\r\n    }\r\n    \r\n\r\n    body, table, td, a { -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; }\r\n    table, td { mso-table-lspace: 0pt; mso-table-rspace: 0pt; }\r\n    img { -ms-interpolation-mode: bicubic; }\r\n\r\n    img { border: 0; height: auto; line-height: 100%; outline: none; text-decoration: none; }\r\n    table { border-collapse: collapse !important; }\r\n    body { height: 100% !important; margin: 0 !important; padding: 0 !important; width: 100% !important; }\r\n\r\n    a[x-apple-data-detectors] {\r\n        color: inherit !important;\r\n        text-decoration: none !important;\r\n        font-size: inherit !important;\r\n        font-family: inherit !important;\r\n        font-weight: inherit !important;\r\n        line-height: inherit !important;\r\n    }\r\n\r\n    div[style*=\"margin: 16px 0;\"] { margin: 0 !important; }\r\n</style>\r\n\r\n\r\n\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n\r\n    <tbody><tr>\r\n        <td bgcolor=\"black\" align=\"center\">\r\n            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\">\r\n                <tbody><tr>\r\n                    <td align=\"center\" valign=\"top\" style=\"padding: 40px 10px 40px 10px;\">\r\n                        <a href=\"#0\" target=\"_blank\">\r\n                            <img alt=\"Logo\" src=\"https://script.tonatheme.com/tonarate/assets/universal/images/logoFavicon/logo_light.png\" width=\"180\" height=\"180\" style=\"display: block;  font-family: \'Lato\', Helvetica, Arial, sans-serif; color: #ffffff; font-size: 18px;\" border=\"0\">\r\n                        </a>\r\n                    </td>\r\n                </tr>\r\n            </tbody></table>\r\n        </td>\r\n    </tr>\r\n\r\n    <tr>\r\n        <td bgcolor=\"black\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">\r\n            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\">\r\n                <tbody><tr>\r\n                    <td bgcolor=\"#ffffff\" align=\"center\" valign=\"top\" style=\"padding: 40px 20px 20px 20px; border-radius: 4px 4px 0px 0px; color: #111111; font-family: \'Lato\', Helvetica, Arial, sans-serif; font-size: 48px; font-weight: 400; letter-spacing: 4px; line-height: 48px;\">\r\n                      <h1 style=\"font-size: 22px; font-weight: 400; margin: 0; border-bottom: 1px solid #727272; width: max-content;\">Hello {{fullname}} ({{username}})</h1>\r\n                    </td>\r\n                </tr>\r\n            </tbody></table>\r\n        </td>\r\n    </tr>\r\n\r\n    <tr>\r\n        <td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">\r\n            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\">\r\n\r\n              <tbody><tr>\r\n                <td bgcolor=\"#ffffff\" align=\"left\" style=\"padding: 20px 30px 40px 30px; color: #666666; font-family: \'Lato\', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px; text-align: center;\">\r\n                  <p style=\"margin: 0;\">{{message}}</p>\r\n                </td>\r\n              </tr>\r\n            </tbody></table>\r\n        </td>\r\n    </tr>\r\n\r\n    <tr>\r\n        <td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 30px 10px 0px 10px;\">\r\n            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"black\" align=\"center\" style=\"padding: 30px 30px 30px 30px; border-radius: 4px 4px 4px 4px; color: #666666; font-family: \'Lato\', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;\">\r\n                    <h2 style=\"font-size: 20px; font-weight: 400; color: white; margin: 0;\">©{{site_name}} All Rights Reserved.</h2>\r\n                  </td>\r\n                </tr>\r\n            </tbody></table>\r\n        </td>\r\n    </tr>\r\n</tbody></table>', 'hi {{fullname}} ({{username}}), {{message}}', 'TonaRate', '{\"name\":\"php\"}', '{\"name\":\"custom\",\"nexmo\":{\"api_key\":\"------\",\"api_secret\":\"------\"},\"twilio\":{\"account_sid\":\"-----------------------\",\"auth_token\":\"-----------------------\",\"from\":\"----------------------\"},\"custom\":{\"method\":\"get\",\"url\":\"https:\\/\\/hostname\\/demo-api-v1\",\"headers\":{\"name\":[\"api_key\",\"Demo Api\"],\"value\":[\"test_api\",\"Demo Api\"]},\"body\":{\"name\":[\"from_number\",\"Demo body Api\"],\"value\":[\"565754\",\"Demo body API\"]}}}', '{\r\n    \"site_name\":\"Name of your site\",\r\n    \"site_currency\":\"Currency of your site\",\r\n    \"currency_symbol\":\"Symbol of currency\"\r\n}', 'ffa929', '1e2a38', 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 'primary', NULL, '2025-01-08 12:39:53');

-- --------------------------------------------------------

--
-- Table structure for table `site_data`
--

CREATE TABLE `site_data` (
  `id` bigint UNSIGNED NOT NULL,
  `data_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_data`
--

INSERT INTO `site_data` (`id`, `data_key`, `data_info`, `created_at`, `updated_at`) VALUES
(1, 'seo.data', '{\"seo_image\":\"1\",\"keywords\":[\"customer\",\"customer reviews\",\"feedback\",\"product review\",\"rate\",\"rating\",\"rating script\",\"ratings\",\"review\",\"review script\",\"reviews\",\"trustpilot\",\"website rating\"],\"social_title\":\"TonaRate - Business Review Platform\",\"description\":\"TonaRate is a platform designed for business reviews, offering a space for users to share their feedback and experiences. It provides a seamless way to connect with companies while maintaining transparency and trust. The system ensures credibility by incorporating features that safeguard against misuse, fostering an environment where reviews hold value and authenticity. It\\u2019s a tool to empower users and businesses alike, promoting growth through constructive feedback and insights.\",\"social_description\":\"TonaRate is a platform designed for business reviews, offering a space for users to share their feedback and experiences. It provides a seamless way to connect with companies while maintaining transparency and trust. The system ensures credibility by incorporating features that safeguard against misuse, fostering an environment where reviews hold value and authenticity. It\\u2019s a tool to empower users and businesses alike, promoting growth through constructive feedback and insights.\",\"image\":\"677d297e938551736255870.png\"}', '2023-08-15 14:11:35', '2025-01-07 13:19:35'),
(8, 'cookie.data', '{\"short_details\":\"We may use cookies or any other tracking technologies when you visit our website, including any other media form, mobile website, or mobile application related or connected to help customize the Site and improve your experience\",\"details\":\"<p>Types of information we gather<br>&nbsp;<\\/p><p><strong>Personal Information:<\\/strong>&nbsp;When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/p><p><strong>Campaign Information:<\\/strong>&nbsp;We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/p><p><strong>Donation Information:<\\/strong>&nbsp;For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/p><p><strong>Usage Data:<\\/strong>&nbsp;We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/p><p>&nbsp;<\\/p><p>Ensuring the security of your information<\\/p><p><strong>User Accounts:<\\/strong>&nbsp;We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/p><p><strong>Campaign Data:<\\/strong>&nbsp;Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/p><p><strong>Donation Records:<\\/strong>&nbsp;Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/p><p>Is any information shared with external parties?<\\/p><p><br>&nbsp;<\\/p><p><strong>No, we do not sell,<\\/strong>&nbsp;trade, or otherwise transfer users\' personally identifiable information to outside parties without explicit consent.<\\/p><p><strong>Exceptional Circumstances:<\\/strong>&nbsp;We may disclose user information in response to legal requirements, enforcement of policies, or protection of rights, property, or safety.<\\/p><p>Duration of information retention<\\/p><p><strong>User Accounts:<\\/strong>&nbsp;We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/p><p><strong>Campaign Data:<\\/strong>&nbsp;Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/p><p><strong>Donation Records:<\\/strong>&nbsp;Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/p><p>Our policies regarding data usage<br>&nbsp;<\\/p><p><strong>Personal Information:<\\/strong>&nbsp;When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/p><p><strong>Campaign Information:<\\/strong>&nbsp;We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/p><p><strong>Donation Information:<\\/strong>&nbsp;For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/p><p><strong>Usage Data:<\\/strong>&nbsp;We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/p>\",\"status\":1}', NULL, '2025-01-07 11:22:12'),
(9, 'maintenance.data', '{\"heading\":\"Under Maintenance\",\"details\":\"<p>We\'re currently sprucing things up to provide you with an even better browsing experience. Our website is temporarily undergoing maintenance, but we\'ll be back online shortly.<\\/p><p>&nbsp;<\\/p><p>In the meantime, if you have any urgent inquiries or need assistance, feel free to reach out to us at <strong>example@example.com<\\/strong>. We apologize for any inconvenience caused and appreciate your patience.<br>&nbsp;<\\/p><p>&nbsp;<\\/p><p>Thank you for your understanding!<\\/p>\"}', NULL, '2025-01-07 11:16:51'),
(11, 'policy_pages.element', '{\"title\":\"Privacy Policy\",\"details\":\"<p>Types of information we gather<br \\/>\\u00a0<\\/p><p><strong>Personal Information:<\\/strong>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/p><p><strong>Campaign Information:<\\/strong>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/p><p><strong>Donation Information:<\\/strong>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/p><p><strong>Usage Data:<\\/strong>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/p><p>\\u00a0<\\/p><p>Ensuring the security of your information<\\/p><p><strong>User Accounts:<\\/strong>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/p><p><strong>Campaign Data:<\\/strong>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/p><p><strong>Donation Records:<\\/strong>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/p><p>Is any information shared with external parties?<\\/p><p><br \\/>\\u00a0<\\/p><p><strong>No, we do not sell,<\\/strong>\\u00a0trade, or otherwise transfer users\' personally identifiable information to outside parties without explicit consent.<\\/p><p><strong>Exceptional Circumstances:<\\/strong>\\u00a0We may disclose user information in response to legal requirements, enforcement of policies, or protection of rights, property, or safety.<\\/p><p>Duration of information retention<\\/p><p><strong>User Accounts:<\\/strong>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/p><p><strong>Campaign Data:<\\/strong>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/p><p><strong>Donation Records:<\\/strong>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/p><p>Our policies regarding data usage<br \\/>\\u00a0<\\/p><p><strong>Personal Information:<\\/strong>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/p><p><strong>Campaign Information:<\\/strong>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/p><p><strong>Donation Information:<\\/strong>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/p><p><strong>Usage Data:<\\/strong>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/p>\"}', '2023-11-09 10:17:26', '2025-01-07 11:13:08'),
(12, 'policy_pages.element', '{\"title\":\"Terms of Service\",\"details\":\"<p>Types of information we gather<br \\/>\\u00a0<\\/p><p><strong>Personal Information:<\\/strong>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/p><p><strong>Campaign Information:<\\/strong>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/p><p><strong>Donation Information:<\\/strong>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/p><p><strong>Usage Data:<\\/strong>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/p><p>\\u00a0<\\/p><p>Ensuring the security of your information<\\/p><p><strong>User Accounts:<\\/strong>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/p><p><strong>Campaign Data:<\\/strong>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/p><p><strong>Donation Records:<\\/strong>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/p><p>Is any information shared with external parties?<\\/p><p><br \\/>\\u00a0<\\/p><p><strong>No, we do not sell,<\\/strong>\\u00a0trade, or otherwise transfer users\' personally identifiable information to outside parties without explicit consent.<\\/p><p><strong>Exceptional Circumstances:<\\/strong>\\u00a0We may disclose user information in response to legal requirements, enforcement of policies, or protection of rights, property, or safety.<\\/p><p>Duration of information retention<\\/p><p><strong>User Accounts:<\\/strong>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/p><p><strong>Campaign Data:<\\/strong>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/p><p><strong>Donation Records:<\\/strong>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/p><p>Our policies regarding data usage<br \\/>\\u00a0<\\/p><p><strong>Personal Information:<\\/strong>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/p><p><strong>Campaign Information:<\\/strong>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/p><p><strong>Donation Information:<\\/strong>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/p><p><strong>Usage Data:<\\/strong>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/p>\"}', '2023-11-09 10:17:51', '2025-01-07 11:14:45'),
(22, 'email_confirm.content', '{\"title\":\"Welcome Back\",\"subtitle\":\"Access your account to manage reviews, track businesses, and stay connected. Log in to unlock all features and personalize your experience.\",\"button_text\":\"Submit\",\"background_image\":\"67137e488963c1729330760.png\",\"email_image\":\"671382a9ed87f1729331881.png\"}', '2024-06-07 11:06:45', '2024-10-19 09:58:02'),
(25, 'banner.content', '{\"title\":\"Transparent Reviews for Smarter\",\"focused_title\":\"Business Choices\",\"subtitle\":\"Find honest reviews from real customers to help you choose the best businesses with confidence.\",\"company_count\":\"100\",\"company_title\":\"+ Companies\",\"company_subtitle\":\"Verified businesses from various industries.\",\"review_count\":\"1200000\",\"review_title\":\"+ Reviews\",\"review_subtitle\":\"Real feedback from real customers.\",\"user_count\":\"500000\",\"user_title\":\"+ Users\",\"user_subtitle\":\"A growing community of trusted reviewers.\",\"background_image\":\"6704b7b2b37681728362418.png\",\"banner_image\":\"6704b7b3245821728362419.png\",\"company_logo\":\"6704b7b3362c11728362419.png\",\"review_logo\":\"6704b7b3373471728362419.png\",\"user_logo\":\"6704b7b3382071728362419.png\"}', '2024-10-08 04:40:18', '2024-10-08 05:16:38'),
(26, 'category.content', '{\"title\":\"Categories\",\"subtitle\":\"Categories to\",\"focused_subtitle\":\"Explore\",\"description\":\"Explore a wide range of business categories to find companies that meet your needs. From tech to retail, discover top-rated businesses in every industry.\"}', '2024-10-08 05:05:06', '2024-10-08 05:11:43'),
(27, 'company.content', '{\"title\":\"Featured Companies\",\"subtitle\":\"Discover top\",\"focused_subtitle\":\"businesses\",\"description\":\"Browse our selection of standout companies, recognized for their exceptional services and customer satisfaction. These businesses have earned top ratings and reliable reviews from our community.\"}', '2024-10-08 05:20:40', '2024-10-08 05:20:40'),
(28, 'why_choose.content', '{\"title\":\"Why Choose Us\",\"subtitle\":\"The Benefits of\",\"focused_subtitle\":\"Choosing Us\",\"description\":\"Experience a reliable platform with transparent reviews, trusted businesses, and a community dedicated to helping you make smarter decisions.\"}', '2024-10-08 05:48:12', '2024-12-30 13:45:59'),
(29, 'recent_review.content', '{\"title\":\"Recent Reviews\",\"subtitle\":\"Fresh Business\",\"focused_subtitle\":\"Reviews\",\"description\":\"Explore the latest feedback from real customers, sharing their experiences and insights on trusted businesses.\"}', '2024-10-08 05:57:32', '2024-10-08 05:57:32'),
(30, 'cta.content', '{\"title\":\"Connect, Share, and Grow\",\"subtitle\":\"Join Our\",\"focused_subtitle\":\"Community\",\"description\":\"Whether you\'re here to share your experiences or grow your business, our platform provides the tools you need to make a real impact. Join today and be part of a trusted network of customers and companies.\"}', '2024-10-08 06:41:32', '2024-10-08 06:41:32'),
(31, 'cta.element', '{\"title\":\"Share Your Experience\",\"description\":\"Help others make informed decisions by leaving a review of your recent experiences with businesses. Your feedback can guide others to trusted services and improve the quality of businesses everywhere. Every review you share builds a stronger, more reliable community.\",\"button_name\":\"Write a Review\",\"url\":\"user\\/login\",\"image\":\"6704d674022d11728370292.png\"}', '2024-10-08 06:51:31', '2025-01-07 13:41:08'),
(32, 'cta.element', '{\"title\":\"Grow Your Business\",\"description\":\"Join our platform to reach a wider audience of potential customers. Build trust with authentic reviews, improve your business reputation, and grow your brand visibility in an ever-competitive market. Let your customers speak for your quality and take your business to the next level.\",\"button_name\":\"Join our platform\",\"url\":\"user\\/register\",\"image\":\"6704d6b1e47f61728370353.png\"}', '2024-10-08 06:52:33', '2025-01-07 13:40:36'),
(33, 'testimonial.content', '{\"title\":\"Testimonial\",\"subtitle\":\"Voices of Our\",\"focused_subtitle\":\"Happy Clients\",\"description\":\"Discover how our platform has helped businesses grow and customers make smarter decisions with genuine feedback from our satisfied users.\",\"quote_image\":\"6704e4e145bed1728373985.png\"}', '2024-10-08 07:53:05', '2024-10-08 07:53:05'),
(34, 'testimonial.element', '{\"user_name\":\"Emily Carter\",\"user_designation\":\"CEO, Omuk Mart\",\"quote\":\"\\\"This platform has truly transformed the way we connect with our customers. The reviews have helped us grow and improve in ways we couldn\\u2019t have imagined.\\\"\",\"user_image\":\"6704e54d7e5751728374093.png\"}', '2024-10-08 07:54:53', '2024-10-08 07:54:53'),
(35, 'testimonial.element', '{\"user_name\":\"Jason Lee\",\"user_designation\":\"Founder, TechWorks\",\"quote\":\"\\\"As a small business, the visibility we\'ve gained from real customer reviews has been a game changer. We couldn\\u2019t be happier with the results!\\\"\",\"user_image\":\"6704e579b3e281728374137.png\"}', '2024-10-08 07:55:37', '2024-10-08 07:55:37'),
(36, 'testimonial.element', '{\"user_name\":\"Olivia Williams\",\"user_designation\":\"MD, Prime Logistics\",\"quote\":\"\\\"The feedback we\\u2019ve received from this platform has been invaluable. It\\u2019s helped us improve our services and build lasting relationships with customers.\\\"\",\"user_image\":\"6704e59cb07211728374172.png\"}', '2024-10-08 07:56:12', '2024-10-08 07:56:12'),
(37, 'faq.content', '{\"title\":\"Frequently Asked Questions\",\"subtitle\":\"Your Queries,\",\"focused_subtitle\":\"Our Solutions\",\"description\":\"We\\u2019ve compiled answers to the most common questions to help you get the information you need quickly and easily.\",\"image\":\"6704ec01c64591728375809.png\"}', '2024-10-08 08:11:18', '2024-10-08 08:23:29'),
(38, 'faq.element', '{\"question\":\"How do I leave a review for a business?\",\"answer\":\"To leave a review, simply search for the business, visit their profile, and click on \\\"Write a Review.\"}', '2024-10-08 08:11:44', '2024-10-08 08:11:44'),
(39, 'faq.element', '{\"question\":\"Are all reviews verified before being published?\",\"answer\":\"Yes, we verify each review to ensure authenticity and prevent spam or misleading information.\"}', '2024-10-08 08:12:04', '2024-10-08 08:12:04'),
(40, 'faq.element', '{\"question\":\"How can my business join the platform?\",\"answer\":\"Businesses can join by signing up through our \\\"Join as a Business\\\" page and completing the registration process.\"}', '2024-10-08 08:12:24', '2024-10-08 08:12:24'),
(41, 'faq.element', '{\"question\":\"Can I edit or delete my review after posting it?\",\"answer\":\"Yes, you can edit or delete your review at any time by visiting your profile and accessing your review history.\"}', '2024-10-08 08:12:42', '2024-10-08 08:12:42'),
(42, 'faq.element', '{\"question\":\"Is there a fee for businesses to join?\",\"answer\":\"While leaving reviews is free, businesses can choose between free and premium plans for additional features.\"}', '2024-10-08 08:12:57', '2024-10-08 08:12:57'),
(43, 'faq.element', '{\"question\":\"How do you handle fake or misleading reviews?\",\"answer\":\"We have a dedicated team that monitors and removes fake or misleading reviews to maintain trust on our platform.\"}', '2024-10-08 08:13:12', '2024-10-08 08:13:12'),
(44, 'faq.element', '{\"question\":\"Can I report an inappropriate review?\",\"answer\":\"Yes, users can report reviews that violate our guidelines, and our team will investigate promptly.\"}', '2024-10-08 08:13:35', '2024-10-08 08:13:35'),
(45, 'blog.content', '{\"title\":\"Our Blog\",\"subtitle\":\"Latest News &\",\"focused_subtitle\":\"Insights\",\"description\":\"Stay up to date with the latest industry news, expert insights, and tips to help you grow your business and make informed decisions.\"}', '2024-10-08 08:43:41', '2024-10-08 08:43:41'),
(46, 'blog.element', '{\"title\":\"5 Proven Strategies to Boost Customer Trust Through Reviews\",\"description\":\"<p><strong>Building customer trust is essential for long-term business success.<\\/strong> In today\\u2019s digital world, customer reviews play a vital role in establishing credibility and attracting new clients. Here are five proven strategies to enhance customer trust through effective use of reviews:<\\/p><p>\\u00a0<\\/p><ol><li><strong>Encourage Authentic Feedback:<\\/strong> Invite your customers to share honest feedback about their experiences with your business. Authentic reviews, whether glowing or constructive, show that your business is transparent and values genuine input. Make it easy for customers to leave reviews by sending follow-up emails or providing clear instructions on your website.<\\/li><li><strong>Respond to Reviews Promptly:<\\/strong> Engage with your customers by responding to their reviews, regardless of whether they are positive or negative. A quick, thoughtful response shows that you care about customer satisfaction and are committed to continuous improvement. This interaction helps potential customers see your responsiveness and dedication to addressing concerns.<\\/li><li><strong>Highlight Positive Reviews:<\\/strong> Showcase your best reviews across your website, social media platforms, and marketing materials. By highlighting satisfied customer testimonials, you provide social proof to potential customers, reinforcing the idea that others have had great experiences with your business. This helps new customers feel more confident in choosing your service.<\\/li><li><strong>Address Negative Reviews Professionally:<\\/strong> Negative reviews happen, but how you handle them makes all the difference. Respond professionally, addressing the issue and offering a resolution. This demonstrates to other customers that you take feedback seriously and are willing to improve. Often, handling criticism well can turn a negative situation into a positive one, showing that your business values customer satisfaction.<\\/li><li><strong>Showcase Verified Reviews:<\\/strong> Use third-party platforms that verify reviews to add an extra layer of trustworthiness. Potential customers are more likely to trust reviews when they know they\\u2019re coming from real people who have actually interacted with your business. Verified reviews remove doubt and provide greater authenticity, which can significantly boost your credibility.<\\/li><\\/ol><p>\\u00a0<\\/p><p><strong>In conclusion,<\\/strong> by implementing these strategies, you can create a strong foundation of trust and transparency with your customers. In turn, this will help you attract more customers, retain existing ones, and ultimately strengthen your brand\\u2019s reputation in the marketplace.<\\/p>\",\"blog_image_1\":\"6704f0e6b33a81728377062.png\"}', '2024-10-08 08:44:22', '2024-10-08 08:44:22'),
(47, 'blog.element', '{\"title\":\"The Future of Online Business: Trends to Watch in 2024\",\"description\":\"<p><strong>Building customer trust is essential for long-term business success.<\\/strong> In today\\u2019s digital world, customer reviews play a vital role in establishing credibility and attracting new clients. Here are five proven strategies to enhance customer trust through effective use of reviews:<\\/p><p>\\u00a0<\\/p><ol><li><strong>Encourage Authentic Feedback:<\\/strong> Invite your customers to share honest feedback about their experiences with your business. Authentic reviews, whether glowing or constructive, show that your business is transparent and values genuine input. Make it easy for customers to leave reviews by sending follow-up emails or providing clear instructions on your website.<\\/li><li><strong>Respond to Reviews Promptly:<\\/strong> Engage with your customers by responding to their reviews, regardless of whether they are positive or negative. A quick, thoughtful response shows that you care about customer satisfaction and are committed to continuous improvement. This interaction helps potential customers see your responsiveness and dedication to addressing concerns.<\\/li><li><strong>Highlight Positive Reviews:<\\/strong> Showcase your best reviews across your website, social media platforms, and marketing materials. By highlighting satisfied customer testimonials, you provide social proof to potential customers, reinforcing the idea that others have had great experiences with your business. This helps new customers feel more confident in choosing your service.<\\/li><li><strong>Address Negative Reviews Professionally:<\\/strong> Negative reviews happen, but how you handle them makes all the difference. Respond professionally, addressing the issue and offering a resolution. This demonstrates to other customers that you take feedback seriously and are willing to improve. Often, handling criticism well can turn a negative situation into a positive one, showing that your business values customer satisfaction.<\\/li><li><strong>Showcase Verified Reviews:<\\/strong> Use third-party platforms that verify reviews to add an extra layer of trustworthiness. Potential customers are more likely to trust reviews when they know they\\u2019re coming from real people who have actually interacted with your business. Verified reviews remove doubt and provide greater authenticity, which can significantly boost your credibility.<\\/li><\\/ol><p>\\u00a0<\\/p><p><strong>In conclusion,<\\/strong> by implementing these strategies, you can create a strong foundation of trust and transparency with your customers. In turn, this will help you attract more customers, retain existing ones, and ultimately strengthen your brand\\u2019s reputation in the marketplace.<\\/p>\",\"blog_image_1\":\"6704f121b2b1e1728377121.png\"}', '2024-10-08 08:45:21', '2024-10-08 08:45:21'),
(48, 'blog.element', '{\"title\":\"How Authentic Feedback Can Elevate Your Brand\\u2019s Reputation\",\"description\":\"<p><strong>Building customer trust is essential for long-term business success.<\\/strong> In today\\u2019s digital world, customer reviews play a vital role in establishing credibility and attracting new clients. Here are five proven strategies to enhance customer trust through effective use of reviews:<\\/p><p>\\u00a0<\\/p><ol><li><strong>Encourage Authentic Feedback:<\\/strong> Invite your customers to share honest feedback about their experiences with your business. Authentic reviews, whether glowing or constructive, show that your business is transparent and values genuine input. Make it easy for customers to leave reviews by sending follow-up emails or providing clear instructions on your website.<\\/li><li><strong>Respond to Reviews Promptly:<\\/strong> Engage with your customers by responding to their reviews, regardless of whether they are positive or negative. A quick, thoughtful response shows that you care about customer satisfaction and are committed to continuous improvement. This interaction helps potential customers see your responsiveness and dedication to addressing concerns.<\\/li><li><strong>Highlight Positive Reviews:<\\/strong> Showcase your best reviews across your website, social media platforms, and marketing materials. By highlighting satisfied customer testimonials, you provide social proof to potential customers, reinforcing the idea that others have had great experiences with your business. This helps new customers feel more confident in choosing your service.<\\/li><li><strong>Address Negative Reviews Professionally:<\\/strong> Negative reviews happen, but how you handle them makes all the difference. Respond professionally, addressing the issue and offering a resolution. This demonstrates to other customers that you take feedback seriously and are willing to improve. Often, handling criticism well can turn a negative situation into a positive one, showing that your business values customer satisfaction.<\\/li><li><strong>Showcase Verified Reviews:<\\/strong> Use third-party platforms that verify reviews to add an extra layer of trustworthiness. Potential customers are more likely to trust reviews when they know they\\u2019re coming from real people who have actually interacted with your business. Verified reviews remove doubt and provide greater authenticity, which can significantly boost your credibility.<\\/li><\\/ol><p>\\u00a0<\\/p><p><strong>In conclusion,<\\/strong> by implementing these strategies, you can create a strong foundation of trust and transparency with your customers. In turn, this will help you attract more customers, retain existing ones, and ultimately strengthen your brand\\u2019s reputation in the marketplace.<\\/p>\",\"blog_image_1\":\"6704f14117a0d1728377153.png\"}', '2024-10-08 08:45:53', '2024-10-08 08:45:53'),
(49, 'footer.content', '{\"title\":\"Stay Informed with\",\"focused_title\":\"Our Newsletter\",\"description\":\"TonaRate is an innovative business review platform designed to bridge the gap between companies and their customers by providing a space for authentic and actionable reviews.\",\"copyright_text\":\"Copyright 2025 . All rights reserved.\"}', '2024-10-08 09:13:25', '2025-01-08 09:30:45'),
(50, 'banner.element', '{\"counter\":\"100\",\"statistic_category\":\"Companies\",\"statistic_detail\":\"Verified businesses from various industries.\",\"image\":\"6704fe66dd2ea1728380518.png\"}', '2024-10-08 09:41:58', '2024-10-08 09:41:58'),
(51, 'banner.element', '{\"counter\":\"1200000\",\"statistic_category\":\"Reviews\",\"statistic_detail\":\"Real feedback from real customers.\",\"image\":\"6704fe8f6eac21728380559.png\"}', '2024-10-08 09:42:39', '2024-10-08 09:42:39'),
(52, 'banner.element', '{\"counter\":\"500000\",\"statistic_category\":\"Users\",\"statistic_detail\":\"A growing community of trusted reviewers.\",\"image\":\"6704feb4815af1728380596.png\"}', '2024-10-08 09:43:16', '2024-10-08 09:43:16'),
(53, 'breadcrumb.content', '{\"image\":\"6705058ff0d521728382351.png\"}', '2024-10-08 10:12:31', '2024-10-08 10:12:32'),
(54, 'login.content', '{\"title\":\"Welcome Back\",\"subtitle\":\"Access your account to manage reviews, track businesses, and stay connected. Log in to unlock all features and personalize your experience.\",\"button_text\":\"Sign In\",\"background_image\":\"6705173a728261728386874.png\",\"login_image\":\"6705173abe8271728386874.png\"}', '2024-10-08 11:27:54', '2024-10-08 11:27:54'),
(55, 'register.content', '{\"title\":\"Welcome On Board\",\"subtitle\":\"Join our community by creating an account today. Register to leave reviews, follow your favorite businesses, and enjoy personalized features.\",\"button_text\":\"Signup\",\"background_image\":\"67052468b024d1728390248.png\",\"register_image\":\"670524690db0a1728390249.png\"}', '2024-10-08 12:24:08', '2024-10-08 12:24:09'),
(56, 'forgot_password.content', '{\"title\":\"Welcome On Board\",\"subtitle\":\"Please provide either your email address or username to retrieve your account.\",\"button_text\":\"Submit\",\"background_image\":\"6706048c7b5441728447628.png\",\"forgot_password_image\":\"6706048ccd9091728447628.png\"}', '2024-10-09 04:20:28', '2024-10-09 04:20:28'),
(57, 'code_verification.content', '{\"title\":\"Welcome On Board\",\"subtitle\":\"A six-digit verification code has been emailed to you. Please check including your Junk\\/Spam Folder.\",\"button_text\":\"Submit\",\"background_image\":\"67060b4d149af1728449357.png\",\"code_verification_image\":\"67060b4d67c7a1728449357.png\"}', '2024-10-09 04:49:17', '2024-10-09 05:38:41'),
(58, 'password_reset.content', '{\"title\":\"Welcome On Board\",\"subtitle\":\"Join our community by creating an account today. Register to leave reviews, follow your favorite businesses, and enjoy personalized features.\",\"button_text\":\"Submit\",\"background_image\":\"670619f011d511728453104.png\",\"reset_image\":\"670619f0674b81728453104.png\"}', '2024-10-09 05:51:44', '2024-10-09 05:51:44'),
(59, 'user_profile.content', '{\"background_image\":\"67063dabe8e7d1728462251.png\"}', '2024-10-09 08:24:11', '2024-10-09 08:24:12'),
(60, 'user_card.content', '{\"background_image\":\"670677112597c1728476945.png\"}', '2024-10-09 12:29:05', '2024-10-09 12:29:05'),
(61, 'company_details.content', '{\"background_image\":\"670a3db2d41a81728724402.png\"}', '2024-10-12 09:13:22', '2024-10-12 09:13:22'),
(62, 'contact_us.content', '{\"address\":\"USA, Florida, 100 Old City House\",\"email\":\"example@example.com\",\"phone\":\"0123-456-789\",\"button_text\":\"Send Message\",\"image\":\"670a5a13d13621728731667.png\"}', '2024-10-12 11:14:27', '2025-01-07 13:43:51'),
(63, 'footer.element', '{\"social_platform_icon\":\"<i class=\\\"ti ti-brand-facebook\\\"><\\/i>\",\"social_platform_url\":\"https:\\/\\/www.facebook.com\"}', '2024-10-19 09:04:47', '2024-10-19 09:07:27'),
(64, 'footer.element', '{\"social_platform_icon\":\"<i class=\\\"ti ti-brand-x\\\"><\\/i>\",\"social_platform_url\":\"https:\\/\\/www.twitter.com\"}', '2024-10-19 09:06:03', '2024-10-19 09:06:03'),
(65, 'footer.element', '{\"social_platform_icon\":\"<i class=\\\"ti ti-brand-linkedin\\\"><\\/i>\",\"social_platform_url\":\"https:\\/\\/www.linkedin.com\"}', '2024-10-19 09:06:35', '2024-10-19 09:06:35'),
(66, 'footer.element', '{\"social_platform_icon\":\"<i class=\\\"ti ti-brand-instagram\\\"><\\/i>\",\"social_platform_url\":\"https:\\/\\/www.instagram.com\"}', '2024-10-19 09:07:06', '2024-10-19 09:07:06'),
(67, 'mobile_confirm.content', '{\"title\":\"Welcome Back\",\"subtitle\":\"Access your account to manage reviews, track businesses, and stay connected. Log in to unlock all features and personalize your experience.\",\"button_text\":\"Submit\",\"background_image\":\"6713853272e5d1729332530.png\",\"mobile_confirmation_image\":\"67138532bd42a1729332530.png\"}', '2024-10-19 10:08:50', '2024-10-19 10:08:50'),
(68, 'user_ban.content', '{\"default_message\":\"You are banned form this website\",\"background_image\":\"67138e8b6a0ee1729334923.png\",\"user_banned_image\":\"67138e8bb5fc21729334923.png\"}', '2024-10-19 10:48:43', '2024-10-19 10:48:43'),
(69, '2fa_confirm.content', '{\"title\":\"Welcome Back\",\"subtitle\":\"Access your account to manage reviews, track businesses, and stay connected. Log in to unlock all features and personalize your experience.\",\"button_text\":\"Submit\",\"background_image\":\"67139e10b8e881729338896.png\",\"two_factor_image\":\"67139e110f0891729338897.png\"}', '2024-10-19 11:54:56', '2024-10-19 11:54:57'),
(70, 'why_choose.element', '{\"heading\":\"Reliable and Secure\",\"description\":\"Count on a platform designed for transparency and trust, ensuring a safe environment for your business reviews.\",\"image\":\"67752566351721735730534.png\"}', '2024-12-30 13:26:23', '2025-01-01 11:22:14'),
(71, 'why_choose.element', '{\"heading\":\"Rewarding Your Loyalty\",\"description\":\"Earn rewards and enjoy exclusive offers tailored for our loyal users, enhancing your experience with us.\",\"image\":\"67752559e4b0d1735730521.png\"}', '2024-12-30 13:26:40', '2025-01-01 11:22:01'),
(72, 'why_choose.element', '{\"heading\":\"Authentic Feedback\",\"description\":\"Make informed decisions with authentic customer feedback that provides valuable insights into trusted businesses.\",\"image\":\"6775254d934771735730509.png\"}', '2024-12-30 13:26:55', '2025-01-01 11:21:50'),
(75, 'policy_pages.element', '{\"title\":\"Support Policy\",\"details\":\"<p>Types of information we gather<br \\/>\\u00a0<\\/p><p><strong>Personal Information:<\\/strong>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/p><p><strong>Campaign Information:<\\/strong>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/p><p><strong>Donation Information:<\\/strong>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/p><p><strong>Usage Data:<\\/strong>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/p><p>\\u00a0<\\/p><p>Ensuring the security of your information<\\/p><p><strong>User Accounts:<\\/strong>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/p><p><strong>Campaign Data:<\\/strong>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/p><p><strong>Donation Records:<\\/strong>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/p><p>Is any information shared with external parties?<\\/p><p><br \\/>\\u00a0<\\/p><p><strong>No, we do not sell,<\\/strong>\\u00a0trade, or otherwise transfer users\' personally identifiable information to outside parties without explicit consent.<\\/p><p><strong>Exceptional Circumstances:<\\/strong>\\u00a0We may disclose user information in response to legal requirements, enforcement of policies, or protection of rights, property, or safety.<\\/p><p>Duration of information retention<\\/p><p><strong>User Accounts:<\\/strong>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/p><p><strong>Campaign Data:<\\/strong>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/p><p><strong>Donation Records:<\\/strong>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/p><p>Our policies regarding data usage<br \\/>\\u00a0<\\/p><p><strong>Personal Information:<\\/strong>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/p><p><strong>Campaign Information:<\\/strong>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/p><p><strong>Donation Information:<\\/strong>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/p><p><strong>Usage Data:<\\/strong>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/p>\"}', '2025-01-07 11:15:53', '2025-01-07 11:15:53'),
(76, 'kyc.content', '{\"verification_required_heading\":\"Verification Needed\",\"verification_required_details\":\"Ensure your account security and access exclusive features by providing the necessary verification details.\",\"verification_pending_heading\":\"Verification Pending\",\"verification_pending_details\":\"Your request for verification is in progress. We appreciate your patience as we ensure the security of your account.\"}', '2025-01-08 09:37:40', '2025-01-08 09:37:40');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_by` int UNSIGNED NOT NULL DEFAULT '0',
  `balance` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0: banned, 1: active',
  `kyc_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `kc` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0: KYC unconfirmed, 2: KYC pending, 1: KYC confirmed',
  `ec` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0: email unconfirmed, 1: email confirmed',
  `sc` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0: mobile unconfirmed, 1: mobile confirmed',
  `ver_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stores verification code',
  `ver_code_send_at` datetime DEFAULT NULL COMMENT 'verification send time',
  `ts` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0: 2fa off, 1: 2fa on',
  `tc` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0: 2fa unconfirmed, 1: 2fa confirmed',
  `tsc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ban_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `advertisements`
--
ALTER TABLE `advertisements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `short_name` (`short_name`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `plugins`
--
ALTER TABLE `plugins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `site_data`
--
ALTER TABLE `site_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`,`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `advertisements`
--
ALTER TABLE `advertisements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plugins`
--
ALTER TABLE `plugins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `site_data`
--
ALTER TABLE `site_data`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
