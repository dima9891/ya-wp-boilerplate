<?php

/**
 * @package Bootscore Child
 *
 * @version 6.0.0
 */

// Exit if accessed directly
defined('ABSPATH') || exit;

define('Carbon_Fields\URL', WP_CONTENT_URL . '/plugins/carbon-fields-plugin');

add_action('after_setup_theme', 'crb_load');

function crb_load()
{
    global $root_dir;
    require_once "$root_dir/vendor/autoload.php";
    \Carbon_Fields\Carbon_Fields::boot();
}

// style and scripts
add_action('wp_enqueue_scripts', 'bootscore_child_enqueue_styles');
function bootscore_child_enqueue_styles()
{

  // Compiled main.css
    $modified_bootscoreChildCss = date('YmdHi', filemtime(get_stylesheet_directory() . '/assets/css/main.css'));
    wp_enqueue_style('main', get_stylesheet_directory_uri() . '/assets/css/main.css', array('parent-style'), $modified_bootscoreChildCss);

  // style.css
    wp_enqueue_style('parent-style', get_template_directory_uri() . '/style.css');

  // custom.js
  // Get modification time. Enqueue file with modification date to prevent browser from loading cached scripts when file content changes.
    $modificated_CustomJS = date('YmdHi', filemtime(get_stylesheet_directory() . '/assets/js/custom.js'));
    wp_enqueue_script('custom-js', get_stylesheet_directory_uri() . '/assets/js/custom.js', array('jquery'), $modificated_CustomJS, false);
}
