Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Defina a origem do seu frontend.
    # Se estiver usando localhost, use o endereço do seu servidor de desenvolvimento.
    # Exemplo: 'http://localhost:5173'
    # Se quiser permitir qualquer origem (não recomendado em produção), use '*'
    origins 'http://localhost:5173'

    # Defina quais métodos HTTP são permitidos.
    # O `options` é crucial para as requisições de "preflight".
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end