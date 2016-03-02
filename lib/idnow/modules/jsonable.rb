module Idnow
  module Jsonable
    def to_h
      instance_variables.each_with_object({}) do |var, result_hash|
        key = var.to_s.delete('@')
        value = if instance_variable_get(var).respond_to?(:to_h)
                  instance_variable_get(var).to_h
                else
                  instance_variable_get(var).to_s
                end
        result_hash[key] = value
      end
    end

    def to_json
      keys_without_underscores(to_h).to_json
    end

    private

    def keys_without_underscores(obj)
      return obj unless obj.is_a?(Hash)
      obj.each_with_object({}) do |(k, v), result|
        result[k.to_s.delete('_')] = keys_without_underscores(v)
      end
    end
  end
end
