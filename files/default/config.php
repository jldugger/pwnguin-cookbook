<?php
  $c->domain_name = "calendar.pwnguin.net";
  //  $c->sysabbr     = 'DAViCal';
  //  $c->admin_email = 'admin@example.net';
  //  $c->system_name = "Example DAViCal Server";
  //  $c->enable_row_linking = true;

$c->pg_connect[] = 'dbname=davical port=5432 user=davical_app';

/**
 * Authentication against PAM using the PWauth helper program.
 */
$c->authenticate_hook['call'] = 'PWAUTH_PAM_check';
$c->authenticate_hook['config'] =  array(
    'path' => '/usr/sbin/pwauth',
    'email_base' => 'pwnguin.net'
);

include('drivers_pwauth_pam.php');

