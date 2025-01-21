module ActiveSupport
  module LoggerThreadSafeLevel
    Logger::Severity.constants.each do |severity| # Cambia esto si la constante no existe
      const_set severity, Logger::Severity.const_get(severity)
    end
  end
end

