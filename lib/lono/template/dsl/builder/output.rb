# Implements:
#
#   template - uses @definition to build a CloudFormation template section
#
class Lono::Template::Dsl::Builder
  class Output < Base
    def template
      camelize(standarize(@definition))
    end

    # Value is the only required property: https://amzn.to/2xbhmk3
    def standarize(definition)
      first, second, _ = definition
      if definition.size == 1 && first.is_a?(Hash) # long form
        first # pass through
      elsif definition.size == 2 && second.is_a?(Hash) # medium form
        if second.key?(:value)
          logical_id, properties = first, second
        else
          logical_id = first
          properties = {value: second}
        end
        { logical_id => properties }
      elsif definition.size == 2 && second.is_a?(String) # short form
        logical_id = first
        properties = second.is_a?(String) ? { value: second } : {}
        { logical_id => properties }
      elsif definition.size == 1
        logical_id = first.to_s
        properties = {value: ref(logical_id) }
        { logical_id => properties }
      else # I dont know what form
        raise "Invalid form provided. definition #{definition.inspect}"
      end
    end
  end
end