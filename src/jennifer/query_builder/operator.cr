module Jennifer
  module QueryBuilder
    struct Operator
      RAW_OPERATORS = [:is, :is_not]
      getter type

      def initialize(@type : Symbol)
      end

      def to_s
        to_sql
      end

      def to_sql
        case @type
        when :like
          "LIKE"
        when :not_like
          "NOT LIKE"
        when :regexp
          "REGEXP"
        when :not_regexp
          "NOT REGEXP"
        when :==
          "="
        when :is
          "IS"
        when :is_not
          "IS NOT"
        else
          @type.to_s
        end
      end

      def filterable_rhs?
        !RAW_OPERATORS.includes?(@type)
      end

      def sql_args
        [] of DB::Any
      end
    end
  end
end
