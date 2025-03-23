cd /var/www/html

$FILE = "/tmp/composer.ran"
if (Test-Path $FILE) {
    Write-Output "chowning /var/www/html/storage/ for www-data"
    & chown -R www-data:www-data /var/www/html/storage/
} else {
    Add-Content -Path /etc/ssh/ssh_config -Value "StrictHostKeyChecking no"
    Write-Output "chowning /var/www/html/storage/ for www-data"
    & chown -R www-data:www-data /var/www/html/storage/
    New-Item -Path $FILE -ItemType File
}

New-Item -Path /var/run/php -ItemType Directory
& /usr/sbin/apachectl start
& bash