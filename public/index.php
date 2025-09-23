<?php

date_default_timezone_set('Europe/Sofia');
set_time_limit(5);
ini_set('max_execution_time',5);

use App\Kernel;

require_once dirname(__DIR__) . '/vendor/autoload_runtime.php';

return function (array $context) {
    return new Kernel($context['APP_ENV'], (bool)$context['APP_DEBUG']);
};
