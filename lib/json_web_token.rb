require 'jwt'

class JsonWebToken
  # Carrega o segredo JWT das credenciais do Rails
  # Certifique-se de que Rails.application.credentials.jwt_secret esteja definido
  SECRET_KEY = ENV['JWT_SECRET_KEY']

  def self.encode(payload, exp = 7.days.from_now)
    # Define o tempo de expiração do token (padrão: 7 dias a partir de agora)
    payload[:exp] = exp.to_i
    # Codifica o payload usando o segredo e o algoritmo HS256
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def self.decode(token)
    # Decodifica o token usando o segredo
    # 'true' para verificar a expiração e o algoritmo
    body = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
    # Converte as chaves do hash para símbolos para fácil acesso
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => e
    # Retorna nil ou levanta uma exceção para token inválido/expirado
    Rails.logger.error "JWT Decode Error: #{e.message}"
    nil
  end
end