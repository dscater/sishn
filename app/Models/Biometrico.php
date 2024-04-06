<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Biometrico extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "estado",
        "marca",
        "serie",
        "modelo",
        "fecha_ingreso",
        "garantia",
        "cod_hdn",
        "manual_usuario",
        "manual_servicio",
        "unidad_area_id",
        "empresa_id",
        "foto",
        "fecha_registro",
    ];

    protected $appends = ["url_foto", "iniciales_nombre", "fecha_registro_t", "fecha_ingreso_t",  "url_manual_usuario", "url_manual_servicio", "mas"];

    public function getUrlFotoAttribute()
    {
        if ($this->foto) {
            return asset("imgs/biometricos/" . $this->foto);
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

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function getFechaIngresoTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_ingreso));
    }

    public function getUrlManualUsuarioAttribute()
    {
        if ($this->manual_usuario) {
            return asset("files/" . $this->manual_usuario);
        }
        return false;
    }

    public function getUrlManualServicioAttribute()
    {
        if ($this->manual_servicio) {
            return asset("files/" . $this->manual_servicio);
        }
        return false;
    }

    public function getMasAttribute()
    {
        return false;
    }
    // relaciones
    public function unidad_area()
    {
        return $this->belongsTo(UnidadArea::class, 'unidad_area_id');
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'empresa_id');
    }

    public function solicitud_mantenimientos()
    {
        return $this->hasMany(SolicitudMantenimiento::class, 'biometrico_Id');
    }
}
