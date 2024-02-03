<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Institucion extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "nombre_sistema",
        "nit",
        "historia",
        "mision",
        "vision",
        "objetivo",
        "nombre_director",
        "foto_director",
        "nombre_subdirector",
        "foto_subdirector",
        "fono1",
        "fono2",
        "correo1",
        "correo2",
        "facebook",
        "youtube",
        "twitter",
        "dir",
        "ubicacion_google",
        "img_organigrama",
        "logo",
    ];

    protected $appends = [
        "iniciales_nombre",
        "url_logo",
        "url_foto_director",
        "url_foto_subdirector",
        "url_img_organigrama",
        "iniciales_director",
        "iniciales_subdirector",

    ];

    public function getInicialesNombreAttribute()
    {
        $array_nombre = explode(" ", $this->nombre);
        $iniciales = "";
        foreach ($array_nombre as $value) {
            $iniciales .= substr($value, 0, 1);
        }

        return $iniciales;
    }

    public function getUrlLogoAttribute()
    {
        if ($this->logo && trim($this->logo) != "") {
            return asset("imgs/" . $this->logo);
        }
        return null;
    }

    public function getUrlFotoDirectorAttribute()
    {
        if ($this->foto_director && trim($this->foto_director) != "") {
            return asset("imgs/" . $this->foto_director);
        }
        return null;
    }

    public function getUrlFotoSubdirectorAttribute()
    {
        if ($this->foto_subdirector && trim($this->foto_subdirector) != "") {
            return asset("imgs/" . $this->foto_subdirector);
        }
        return null;
    }

    public function getUrlImgOrganigramaAttribute()
    {
        if ($this->img_organigrama && trim($this->img_organigrama) != "") {
            return asset("imgs/" . $this->img_organigrama);
        }
        return null;
    }

    public function getInicialesDirectorAttribute()
    {
        $array_nombre = explode(" ", $this->nombre_director);

        $iniciales = substr($array_nombre[0], 0, 1) . substr($array_nombre[1], 0, 1);
        return $iniciales;
    }

    public function getInicialesSubdirectorAttribute()
    {
        if ($this->nombre_subdirector) {
            $array_nombre = explode(" ", $this->nombre_subdirector);

            if ($array_nombre && count($array_nombre) > 0) {
                $iniciales = substr($array_nombre[0], 0, 1) . substr($array_nombre[1], 0, 1);
                return $iniciales;
            }
        }
        return null;
    }
}
