<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UnidadArea extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "descripcion",
        "user_id",
        "ubicacion",
        "unidad",
        "fecha_registro",
        "status",
    ];


    protected $appends = ["fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }


    // relaciones
    public function user()
    {
        return $this->belongsTo(User::class, "user_id");
    }

    public function biometricos()
    {
        return $this->hasMany(Biometrico::class, 'unidad_area_id')->where("status", 1);
    }

    public function repuestos()
    {
        return $this->hasMany(Repuesto::class, 'unidad_area_id')->where("status", 1);
    }
}
