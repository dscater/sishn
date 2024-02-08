<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Servicio extends Model
{
    use HasFactory;

    protected $fillable = [
        "solicitud_mantenimiento_id",
        "fecha_entrega",
        "procedimientos",
        "observaciones",
        "recomendaciones",
        "diagnostico_previo",
        "estado_equipo",
        "trabajo_realizado",
        "capacitacion",
        "descripcion",
        "fecha_ini",
        "fecha_fin",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t", "fecha_entrega_t", "fecha_ini_t", "fecha_fin_t", "mas"];


    public function getFechaEntregaTAttribute()
    {
        if ($this->fecha_entrega) {
            return date("d/m/Y", strtotime($this->fecha_entrega));
        }
        return "";
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
        if ($this->fecha_registro) {
            return date("d/m/Y", strtotime($this->fecha_registro));
        }
        return "";
    }
    public function getMasAttribute()
    {
        return false;
    }

    // relaciones
    public function solicitud_mantenimiento()
    {
        return $this->belongsTo(SolicitudMantenimiento::class, 'solicitud_mantenimiento_id');
    }
}
