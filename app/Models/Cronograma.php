<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cronograma extends Model
{
    use HasFactory;
    protected $fillable = [
        "solicitud_mantenimiento_id",
        "descripcion",
        "date",
        "user_id",
    ];

    public function solicitud_mantenimiento()
    {
        return $this->belongsTo(SolicitudMantenimiento::class, 'solicitud_mantenimiento_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
