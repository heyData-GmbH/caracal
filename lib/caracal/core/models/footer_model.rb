require 'caracal/core/models/base_model'


module Caracal
  module Core
    module Models

      # This class handles block options passed to the footer method.
      class FooterModel < BaseModel

        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------

        # constants
        const_set(:DEFAULT_FOOTER_SHOW, false)

        # accessors
        attr_reader :footer_show
        attr_reader :page_width
        attr_reader :page_margin_left
        attr_reader :page_margin_right

        # initialization
        def initialize(options={}, &block)
          @footer_show   = DEFAULT_FOOTER_SHOW

          if content = options.delete(:content)
            p content, options.dup, &block
          end

          super options, &block
        end


        #-------------------------------------------------------------
        # Public Methods
        #-------------------------------------------------------------
        #
        #=============== DATA ACCESSORS =======================

        def contents
          @contents ||= []
        end


        #=============== SETTERS ==============================

        def show(value)
          @footer_show = !!value
        end

        #=============== SETTERS ==============================

        # integers
        [:width, :margin_left, :margin_right].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@page_#{ m }", value.to_i)
          end
        end

        #=============== VALIDATION ===========================

        def valid?
          footer_show
        end


        #-------------------------------------------------------------
        # Private Instance Methods
        #-------------------------------------------------------------
        private

        def option_keys
          [:content, :show, :width, :margin_left, :margin_right]
        end
      end
    end
  end
end
