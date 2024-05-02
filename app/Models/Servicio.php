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
        "repuestos",
        "fecha_ini",
        "fecha_fin",
        "fecha_registro",
        "status",
    ];

    protected $appends = ["fecha_registro_t", "fecha_entrega_t", "fecha_ini_t", "fecha_fin_t", "array_repuestos", "repuestos_txt", "array_repuestos_txt", "mas"];

    public function getRepuestosTxtAttribute()
    {

        if (count($this->array_repuestos) > 0) {
            $repuestos = Repuesto::whereIn("id", $this->array_repuestos)->pluck("nombre")->toARray();
            return implode(", ", $repuestos);
        }
        return "-";
    }
    public function getArrayRepuestosTxtAttribute()
    {
        if (count($this->array_repuestos) > 0) {
            $repuestos = Repuesto::whereIn("id", $this->array_repuestos)->pluck("nombre")->toARray();
            return $repuestos;
        }
        return "";
    }

    public function getArrayRepuestosAttribute()
    {
        if (strlen($this->repuestos) > 0) {
            return explode(",", $this->repuestos);
        }
        return [];
    }

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
