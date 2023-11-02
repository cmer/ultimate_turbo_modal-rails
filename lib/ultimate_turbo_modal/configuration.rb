module UltimateTurboModal
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  delegate :flavor, :flavor=, :close_button, :close_button=,
    :advance, :advance=, :padding, :padding=, to: :configuration

  class Configuration
    attr_reader :flavor, :close_button, :advance, :padding

    def initialize
      @flavor = :tailwind
      @close_button = true
      @advance = true
      @padding = true
    end

    def flavor=(flavor)
      raise ArgumentError.new("Flavor must be a symbol.") unless flavor.is_a?(Symbol) || flavor.is_a?(String)
      @flavor = flavor.to_sym
    end

    def close_button=(close_button)
      raise ArgumentError.new("Close button must be a boolean.") unless [true, false].include?(close_button)
      @close_button = close_button
    end

    def advance=(advance)
      raise ArgumentError.new("Advance must be a boolean.") unless [true, false].include?(advance)
      @advance = advance
    end

    def padding=(padding)
      if [true, false].include?(padding) || padding.is_a?(String)
        @padding = padding
      else
        raise ArgumentError.new("Padding must be a boolean or a String.")
      end
    end
  end
end

# Make sure the configuration object is set up when the gem is loaded.
UltimateTurboModal.configure
