<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Documento extends Model
{
    use HasFactory;

    protected $fillable = [
        "descripcion"
    ];

    public function documento_archivos()
    {
        return $this->hasMany(DocumentoArchivo::class, 'documento_id');
    }
}
