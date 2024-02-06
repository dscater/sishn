<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SolicitudMantenimiento extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo",
        "nombre_responsable",
        "ci_responsable",
        "nombre_tecnico",
        "ci_tecnico",
        "tipo_mantenimiento",
        "motivo_mantenimiento",
        "diagnostico",
        "otros",
        "fecha_solicitud",
        "biometrico_id",
        "repuestos",
        "descripcion",
        "fecha",
        "hora",
        "fecha_registro"
    ];

    protected $appends = ["fecha_registro_t", "fecha_solicitud_t"];


    public function getFechaSolicitudTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_solicitud));
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    // relaciones
    public function biometrico()
    {
        return $this->belongsTo(Biometrico::class, 'biometrico_id');
    }
}
