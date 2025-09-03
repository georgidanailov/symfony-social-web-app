<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HelloController
{
    private array $messages = [
        "Hello", "Hi", "Bye!"
    ];

    #[Route('/{limit<\d+>?3', name: 'app_index')]
    public function index(): Response
    {
        return new Response("HI!");
        return new Response(implode(',', $this->messages));
    }

    #[Route('/messages/{id<\d+>}', name: 'app_show_one')]
    public function showOne(int $id): Response
    {
        return new Response($this->messages[$id]);
    }
}