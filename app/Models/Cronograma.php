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

    protected $appends = ["backgroundColor", "date_t"];

    public function getDateTAttribute()
    {
        return date("d/m/Y", strtotime($this->date));
    }

    public function getBackgroundColorAttribute()
    {
        $fecha_actual = date("Y-m-d");
        if ($this->date < $fecha_actual) {
            return "red";
        }
        return "green";
    }

    public function solicitud_mantenimiento()
    {
        return $this->belongsTo(SolicitudMantenimiento::class, 'solicitud_mantenimiento_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
