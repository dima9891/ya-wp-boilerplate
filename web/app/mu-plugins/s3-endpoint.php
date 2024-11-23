<?php
/**
 * Plugin Name:  S3 Custom Endpoint
 * Description:  Filter S3 Uploads params.
 * Version:      1.0.0
 * Author:       Dmitry Rezvykh
 */

add_filter('s3_uploads_s3_client_params', function ($params) {
    $params['endpoint'] = getenv('S3_UPLOADS_ENDPOINT');
    $params['use_path_style_endpoint'] = false;
    $params['debug'] = false; // Set to true if uploads are failing.
    return $params;
});
