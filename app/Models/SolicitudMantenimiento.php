<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class SolicitudMantenimiento extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo",
        "nro",
        "nombre_responsable",
        "ci_responsable",
        "nombre_tecnico",
        "ci_tecnico",
        "tipo_mantenimiento",
        "motivo_mantenimiento",
        "diagnostico",
        "otros",
        "fecha_solicitud",
        "fecha_entrega",
        "biometrico_id",
        "repuestos",
        "fecha_registro"
    ];

    protected $appends = ["fecha_registro_t", "fecha_solicitud_t", "fecha_entrega_t", "array_repuestos", "repuestos_txt", "array_repuestos_txt", "mas", "qr"];

    public function getQrAttribute()
    {
        $qr = "data:image/svg+xml;base64,";
        $codigo = $this->biometrico->nombre . "|" . $this->biometrico->marca . "|" . $this->biometrico->modelo . "|" . $this->biometrico->serie . "|" . $this->biometrico->unidad_area->nombre;
        $qr = $qr . base64_encode(QrCode::format('svg')->size(70)->generate($codigo));
        return $qr;
    }

    public function getFechaSolicitudTAttribute()
    {
        if ($this->fecha_solicitud) {
            return date("d/m/Y", strtotime($this->fecha_solicitud));
        }
        return "";
    }

    public function getFechaEntregaTAttribute()
    {
        if ($this->fecha_entrega) {
            return date("d/m/Y", strtotime($this->fecha_entrega));
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
    public function getRepuestosTxtAttribute()
    {
        $repuestos = Repuesto::whereIn("id", $this->array_repuestos)->pluck("nombre")->toARray();
        return implode(", ", $repuestos);
    }
    public function getArrayRepuestosTxtAttribute()
    {
        $repuestos = Repuesto::whereIn("id", $this->array_repuestos)->pluck("nombre")->toARray();
        return $repuestos;
    }

    public function getArrayRepuestosAttribute()
    {
        return explode(",", $this->repuestos);
    }

    public function getMasAttribute()
    {
        return false;
    }

    public static function getNroCodigo()
    {
        $ultimo = SolicitudMantenimiento::orderBy("nro", "desc")->first();
        if ($ultimo) {
            return (int)$ultimo->nro + 1;
        }
        return 1;
    }

    // relaciones
    public function biometrico()
    {
        return $this->belongsTo(Biometrico::class, 'biometrico_id');
    }

    public function cronogramas()
    {
        return $this->hasMany(Cronograma::class, 'solicitud_mantenimiento_id');
    }

    public function servicio()
    {
        return $this->hasOne(Servicio::class, 'solicitud_mantenimiento_id');
    }
}
