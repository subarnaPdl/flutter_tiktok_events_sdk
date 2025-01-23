import TikTokBusinessSDK

struct SendEventHandler {
    static func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        do {

            let eventTypeName = args["event_type_name"] as? String ?? "none"
            let parameters = args["parameters"]
            let eventId = args["event_id"] as? String
            let eventName = args["event_name"] as? String
            

            let eventBuilder = createEventBuilder(eventTypeName: eventName, eventId: eventId)
            
            parameters.forEach { (key, value) in
                eventBuilder.addProperty(key, "\(value)")
                
            }
            
            let event = eventBuilder.build()
            TikTokBusinessSDK.trackEvent(event)
            
            result("Evento '\(event.name)' enviado com sucesso!")
        } catch {
            result(FlutterError(code: "EVENT_ERROR", message: "Erro ao enviar o evento: \(error.localizedDescription)", details: nil))
        }
    }
    
    private static func createEventBuilder(eventTypeName: String, eventId: String?) -> TTBaseEventBuilder {
        switch eventTypeName {
        case "AddToCart":
            return eventId != nil ? TTAddToCartEvent.builder(withEventId: eventId!) : TTAddToCartEvent.builder()
        case "AddToWishlist":
            return eventId != nil ? TTAddToWishlistEvent.builder(withEventId: eventId!) : TTAddToWishlistEvent.builder()
        case "Checkout":
            return eventId != nil ? TTCheckoutEvent.builder(withEventId: eventId!) : TTCheckoutEvent.builder()
        case "Purchase":
            return eventId != nil ? TTPurchaseEvent.builder(withEventId: eventId!) : TTPurchaseEvent.builder()
        case "ViewContent":
            return eventId != nil ? TTViewContentEvent.builder(withEventId: eventId!) : TTViewContentEvent.builder()
        default:
            return eventId != nil ? TTBaseEvent.builder(eventTypeName, eventId!) : TTBaseEvent.builder(eventTypeName)
        }
    }
}
