<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('empresas', function (Blueprint $table) {
            $table->id();
            $table->string("nombre", 255);
            $table->string("nit", 255)->nullable();
            $table->string("fono", 255)->nullable();
            $table->date("fecha_ini", 255)->nullable();
            $table->date("fecha_fin", 255)->nullable();
            $table->string("correo", 255)->nullable();
            $table->string("dir", 255)->nullable();
            $table->string("logo", 255)->nullable();
            $table->date("fecha_registro")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('empresas');
    }
};
