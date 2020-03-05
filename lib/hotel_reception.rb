module Hotel
  class HotelReception
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []
      20.times do |i|
        i += 1
        @rooms << Hotel::Room.new(i, 200)
      end
    end

    def find_reservation(id)
      return reservations.find { |res| res.id == id }
    end

    def available_rooms(check_in_time, check_out_time)
      dates = Hotel::DateRange.new(check_in_time, check_out_time)
      
      unavail_rooms = []
      unavail_rooms = reservations.map { |res| res.room if res.date_range.overlap?(dates) }
      return @rooms.difference(unavail_rooms)
    end
    
    def list_reservations(date:, room_id: nil)
      date = Date.new(date[0], date[1], date[2]) unless date.class == Date
      res_by_date = reservations.select { |res| res.date_range.include?(date) }
      if room_id
        res_by_room = reservations.select { |res| res.room.id == room_id }
        res_by_room.map! { |res| res.room.id }
        return res_by_date.difference(res_by_room)
      else
        return res_by_date
      end
    end

    def make_reservation(check_in_time, check_out_time)
      room = available_rooms(check_in_time, check_out_time).first
      @reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
      return reservations.last
    end
  end
end