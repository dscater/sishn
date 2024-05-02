<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Empresa extends Model
{
    use HasFactory;
    protected $fillable = [
        "nombre",
        "nit",
        "fono",
        "fecha_ini",
        "fecha_fin",
        "correo",
        "dir",
        "logo",
        "pais",
        "fecha_registro",
        "status",
    ];

    protected $appends = ["url_logo", "iniciales_nombre", "fecha_registro_t", "fecha_ini_t", "fecha_fin_t"];

    public function getUrlLogoAttribute()
    {
        if ($this->logo) {
            return asset("imgs/empresas/" . $this->logo);
        }
        return false;
    }

    public function getInicialesNombreAttribute()
    {
        $array_nombre = explode(" ", $this->nombre);
        $iniciales = "";
        foreach ($array_nombre as $value) {
            $iniciales .= substr($value, 0, 1);
        }

        return $iniciales;
    }

    public function getFechaIniTAttribute()
    {
        if ($this->fecha_ini) {
            return date("d/m/Y", strtotime($this->fecha_ini));
        }
        return "";
    }
    public function getFechaFinTAttribute()
    {
        if ($this->fecha_fin) {
            return date("d/m/Y", strtotime($this->fecha_fin));
        }
        return "";
    }
    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }
}
