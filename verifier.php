<?php
require "cabinet/inc/db.php";
$db = db();

$tables = $db->query("SELECT COUNT(*) FROM sqlite_master WHERE type = 'table'")->fetchColumn();
$admin = $db->query("SELECT COUNT(*) FROM users WHERE username = 'admin'")->fetchColumn();

echo "NOMBRE DE TABLES : " . $tables . PHP_EOL;
echo "COMPTE ADMIN : " . $admin . PHP_EOL;
?>
