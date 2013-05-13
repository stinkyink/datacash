module SimpleMerchant
  module Datacash 
    class SessionRequest
      def initialize(options = {})
        @client                     = options.fetch(:client)
        @datacash_page_set_id       = options.fetch(:datacash_page_set_id, 0)
        @datacash_3d_secure_enabled = options.fetch(:datacash_3d_secure_enabled, true)
      rescue KeyError => e
        raise ArgumentError, "Missing option - #{e}"
      end

      private
      attr_reader :client

      #belongs_to :order

      #before_validation :generate_our_reference, :on => :create
      #before_validation :generate_amount, :on => :create
      #before_validation :execute_session_request, :on => :create
      #serialize :response

      #TIME_FORMAT = '%Y%m%d %H:%M:%S'

      #attr_accessor :payment_url

      #def update_status!
      #response = DataCash.query(datacash_reference)

      ## if the server returns 200 ok and datacash returns a status of 1
      ## payment has been successfully taken and there will be auth attempts
      #if response.successful? && response.status == 1

      #attempts = []      
      #attempts << response.data['HpsTxn']['AuthAttempts']['Attempt']
      #attempts.flatten!

      #for attempt in attempts

      #if order.order_payments.where('datacash_reference = ?', attempt['datacash_reference']).count == 0

      #if attempt['reason'] == 'ACCEPTED'
      #order.order_payments.create(
      #:amount             => amount,
      #:datacash_reference => attempt['datacash_reference']
      #)
      #end
      #end
      #end

      #self.response = response.data
      #self.successful = true
      #end
      #self.updated_at = Time.now
      #save
      #end



      #private
      #def generate_our_reference
        #self.our_reference = "#{self.order.order_number}-#{Time.now.to_i.to_s}".first(30)
      #end

      #def generate_amount
        #self.amount = order.total_inc_vat
      #end

      #def execute_session_request
        #response = session_request

        ## if the server returns 200 ok and datacash returns a status of 1
        ## the session has been successfully created
        #if response.successful? && response.status == 1
          #self.datacash_reference = response.datacash_reference
          #self.payment_url = "#{response.data['HpsTxn']['hps_url']}?HPS_SessionID=#{response.data['HpsTxn']['session_id']}"
        #else
          #logger.error "datacash did not return a valid session response"
          #errors.add(:datacash_reference, "datacash did not return a valid session response")
        #end
      #end

      ## Requests a session from DataCash
      #def session_request
        #DataCash.request do |xml|

          #xml.tag! :TxnDetails do

            #xml.tag! :merchantreference, our_reference # reference can not be more than 30 characters
            #xml.tag! :amount, amount.to_s, :currency => 'GBP'

            #if APP_CONFIG[:datacash_3d_secure_enabled] == 'true'

              #xml.tag! :ThreeDSecure do
                #xml.tag! :verify, 'yes'
                #xml.tag! :merchant_url, "http://#{APP_CONFIG[:domain]}"
                #xml.tag! :purchase_desc, 'goods'
                #xml.tag! :purchase_datetime, Time.now.strftime(TIME_FORMAT)

                #xml.tag! :Browser do
                  #xml.tag! :device_category, 0
                  #xml.tag! :accept_headers, '*/*'
                  #xml.tag! :user_agent, 'Mozilla/5.0'
                #end
              #end
            #end

            #xml.tag! :The3rdMan do
              #xml.tag! :CustomerInformation do
                #xml.tag! :order_number, order.order_number
                #xml.tag! :customer_reference, order.customer.id
                #xml.tag! :title, order.invoice_address.title
                #xml.tag! :forename, order.invoice_address.first_name
                #xml.tag! :surname, order.invoice_address.last_name
                #xml.tag! :delivery_title, order.delivery_address.title
                #xml.tag! :delivery_forename, order.delivery_address.first_name
                #xml.tag! :delivery_surname, order.delivery_address.last_name
                #xml.tag! :telephone, order.invoice_address.phone.gsub(/[\D]/, '')
                #xml.tag! :email, order.email
                #xml.tag! :ip_address, order.ip_address
              #end
              #xml.tag! :DeliveryAddress do
                #xml.tag! :street_address_1, order.delivery_address.address1
                #xml.tag! :street_address_2, order.delivery_address.address2
                #xml.tag! :city, order.delivery_address.town
                #xml.tag! :county, order.delivery_address.county
                #xml.tag! :postcode, order.delivery_address.postcode
              #end
              #xml.tag! :BillingAddress do
                #xml.tag! :street_address_1, order.invoice_address.address1
                #xml.tag! :street_address_2, order.invoice_address.address2
                #xml.tag! :city, order.invoice_address.town
                #xml.tag! :county, order.invoice_address.county
                #xml.tag! :postcode, order.invoice_address.postcode
              #end

              #unless order.discount
                #xml.tag! :OrderInformation do
                  #xml.tag! :Products, :count => order.order_lines.count do
                    #for order_line in order.order_lines
                      #xml.tag! :Product do
                        #xml.tag! :code, order_line.reference
                        #xml.tag! :quantity, order_line.quantity
                        #xml.tag! :price, order_line.unit_price
                        #xml.tag! :prod_description, order_line.name
                        #if order_line.product
                          #xml.tag! :prod_id, order_line.product.id
                          #xml.tag! :prod_category, order_line.product.category.name if order_line.product.category
                          #xml.tag! :prod_type, order_line.product.product_type.name if order_line.product.product_type
                        #end
                      #end
                    #end
                  #end
                #end
              #end
            #end
          #end

          #xml.tag! :HpsTxn do
            #xml.tag! :method, 'setup_full'
            #xml.tag! :page_set_id, APP_CONFIG[:datacash_page_set_id]
            #xml.tag! :return_url, "http#{'s' unless Rails.env == 'development'}://#{APP_CONFIG[:domain]}/order/payment"
            #xml.tag! :expiry_url, "http#{'s' unless Rails.env == 'development'}://#{APP_CONFIG[:domain]}/order/payment/new"
          #end

          #xml.tag! :CardTxn do
            #xml.tag! :method, 'auth'
            #xml.tag! :Card do
              #xml.tag! :Cv2Avs do
                #xml.tag! :street_address1, order.invoice_address.address1.first(100) # bank only checks numeric data
                #xml.tag! :postcode, order.invoice_address.postcode.first(10)
              #end
            #end
          #end
        #end
      #end    
    end
  end
end

