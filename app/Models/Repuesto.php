<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Repuesto extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre", "unidad_area_id",
        "status",
    ];

    public function unidad_area()
    {
        return $this->belongsTo(UnidadArea::class, 'unidad_area_id');
    }
}
