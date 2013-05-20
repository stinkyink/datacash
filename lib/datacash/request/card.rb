module Datacash
  module Request
    class Card < Base
      root "Card"

      coerce_key :cv2avs, Cv2Avs
    end
  end
end
