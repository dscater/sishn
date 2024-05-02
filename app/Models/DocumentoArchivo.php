<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DocumentoArchivo extends Model
{
    use HasFactory;

    protected $fillable = [
        "documento_id",
        "archivo",
        "status",
    ];

    protected $appends = ["url_archivo", "thumb"];

    public function getThumbAttribute()
    {
        $array_archivo = explode(".", $this->archivo);
        $extension = $array_archivo[1];

        $imagenes = ["jpg", "jpeg", "png", "webp", "gif", "jfif"];

        if (in_array($extension, $imagenes)) {
            return asset("files/" . $this->archivo);
        }
        return asset("imgs/attach.png");
    }

    public function getUrlArchivoAttribute()
    {
        return asset("files/" . $this->archivo);
    }

    public function documento()
    {
        return $this->belongsTo(Documento::class, 'documento_id');
    }
}
