<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Models\BackupBD;
use App\Models\Institucion;
use App\Providers\RouteServiceProvider;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response;
use Illuminate\Support\Facades\Http;

class AuthenticatedSessionController extends Controller
{
    /**
     * Display the login view.
     */
    public function create(): Response
    {
        return Inertia::render('Auth/Login', [
            'canResetPassword' => Route::has('password.request'),
            'status' => session('status'),
        ]);
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request): RedirectResponse
    {
        $request->authenticate();

        $request->session()->regenerate();

        if (Auth::user()->status == 0) {
            Auth::logout();

            throw ValidationException::withMessages([
                'usuario' =>  "Esta cuenta fue dada de baja"
            ]);
        }

        // crear backup
        $backup = new BackupBD();
        $backup->crearBackup();

        return redirect()->intended(RouteServiceProvider::HOME);
    }

    public function verifica_captcha(Request $request)
    {
        $configuracion = Institucion::first();

        $response = Http::asForm()->post("https://www.google.com/recaptcha/api/siteverify", [
            // "secret" => '6LfLgEAkAAAAAEUx6mam_35HPbm5DUl0u4bfHKay',
            "secret" => $configuracion->captcha_servidor,
            "response" => $request->input("g-recaptcha-response")
        ])->object();
        return response()->JSON($response);
    }


    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): RedirectResponse
    {
        Auth::guard('web')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();
        // crear backup
        $backup = new BackupBD();
        $backup->crearBackup();

        return redirect('/login');
    }
}
