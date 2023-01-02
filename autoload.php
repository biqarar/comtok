<?php

class autoload
{

	private static $loaded = [];


	/**
	 * @param $_class_name
	 *
	 * @return void
	 */
	public static function load($_class_name)
	{
		// check loaded before
		if(!isset(self::$loaded[$_class_name]))
		{

			$load = self::findClassPath($_class_name);

			if($load)
			{
				self::$loaded[$_class_name] = true;
			}
		}

	}


	/**
	 * Detect file path by class name
	 *
	 * @param $_class_name
	 *
	 * @return bool
	 */
	private static function findClassPath($_class_name)
	{
		$filePath = $_class_name . '.php';

		$filePath = str_replace('\\', DIRECTORY_SEPARATOR, $filePath);

		if(is_file($filePath))
		{
			require_once $filePath;

			return true;
		}
		else
		{
			$errorMsg = sprintf('File %s not found', $filePath);
			die($errorMsg);

		}

	}

}


spl_autoload_register(['autoload', 'load']);