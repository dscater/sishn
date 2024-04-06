<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

class BackupBD extends Model
{
    use HasFactory;

    private $ruta_mysql = "C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin";

    public function crearBackup()
    {
        $dbhost = config('database.connections.mysql.host');
        $dbport = config('database.connections.mysql.port');
        $dbname = config('database.connections.mysql.database');
        $dbuser = config('database.connections.mysql.username');
        $dbpass = config('database.connections.mysql.password');
        //save file
        $file_name = $dbname . '_' . date("d_m_Y_H_i_s") . '.sql';
        $path_mysqldump = $this->ruta_mysql;
        $dbfile = public_path("/backups/" . $file_name);
        Log::debug($dbfile);
        $mysqldump = $path_mysqldump . "\mysqldump";
        if ($path_mysqldump == "") {
            $mysqldump = "mysqldump";
        }
        $command = "$mysqldump -u$dbuser $dbname > $dbfile";
        if ($dbpass != "") {
            $command = "$mysqldump -u$dbuser -p$dbpass $dbname > $dbfile";
        }
        exec($command, $output, $worked);
        switch ($worked) {
            case 0:
                Log::debug('La base de datos <b>' . $dbname . '</b> se ha almacenado correctamente en la siguiente ruta ' .  $dbfile . '</b>');
                break;
            case 1:
                Log::debug('Se ha producido un error al exportar <b>' . $dbname . '</b> a ' .  $dbfile . '</b>');
                break;
            case 2:
                Log::debug('Se ha producido un error de exportación, compruebe la siguiente información: <br/><br/><table><tr><td>Nombre de la base de datos:</td><td><b>' . $dbname . '</b></td></tr><tr><td>Nombre de usuario MySQL:</td><td><b>' . $dbuser . '</b></td></tr><tr><td>Contraseña MySQL:</td><td><b>NOTSHOWN</b></td></tr><tr><td>Nombre de host MySQL:</td><td><b>' . $dbhost . '</b></td></tr></table>');
                break;
        }

        if ($worked == 0) {
            return true;
        }
        return false;
    }
}