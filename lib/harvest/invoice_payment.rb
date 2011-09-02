module Harvest
  class InvoicePayment < Hashie::Dash
    include Harvest::Model
    
    def self.json_root; "payment"; end
    
    property :id
    property :amount
    property :paid_at
    property :invoice_id
    property :recorded_by
    property :recorded_by_email
    property :notes
    property :authorization
    property :payment_gateway_id
    property :pay_pal_transaction_id
    property :created_at
    property :updated_at
        
  end
end