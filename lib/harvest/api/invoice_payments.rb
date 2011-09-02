module Harvest
  module API
    class InvoicePayments < Base
          
      def all(invoice)
        response = request(:get, credentials, "/invoices/#{invoice.to_i}/payments")
        Harvest::InvoicePayment.parse(response.parsed_response)
      end
      
      def find(invoice, id)
        response = request(:get, credentials, "/invoices/#{invoice.to_i}/payments/#{id}")
        Harvest::InvoicePayment.parse(response.parsed_response).first
      end
      
      def create(invoice_payment)
        invoice_payment = Harvest::InvoicePayment.wrap(invoice_payment)
        response = request(:post, credentials, "/invoices/#{invoice_payment.invoice_id}/payments", :body => invoice_payment.to_json)
        id = response.headers["location"].match(/\/.*\/(\d+)\/.*\/(\d+)/)[2]
        find(invoice_payment.invoice_id, id)
      end
      
      def update(invoice_payment)
        invoice_payment = Harvest::InvoicePayment.wrap(invoice_payment)
        request(:put, credentials, "/invoices/#{invoice_payment.invoice_id}/payments/#{invoice_payment.to_i}", :body => invoice_payment.to_json)
        find(invoice_payment.invoice_id, invoice_payment.id)
      end
      
      def delete(invoice_payment)
        response = request(:delete, credentials, "/invoices/#{invoice_payment.invoice_id}/payments/#{invoice_payment.to_i}")
        invoice_payment.id
      end
    end
  end
end