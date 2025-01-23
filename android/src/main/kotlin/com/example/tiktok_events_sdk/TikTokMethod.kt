package com.example.tiktok_events_sdk

import android.content.Context
import com.tiktok.TikTokBusinessSdk.TTConfig
import com.tiktok.TikTokBusinessSdk
import com.tiktok.appevents.base.TTBaseEvent
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object TikTokMethodName {
    const val INITIALIZE: String = "initialize"
    const val IDENTIFY: String = "identify"
    const val SEND_EVENT: String = "sendEvent"
    const val LOGOUT: String = "logout"
}

sealed class TikTokMethod(
    val type: String,
) {
    abstract fun call(
        context: Context,
        call: MethodCall,
        result: MethodChannel.Result,
        exception: Exception?
    )

    fun MethodChannel.Result.emitError(errorMessage: String) {
        val stackTrace = Thread.currentThread().stackTrace.map { element -> element.toString() }
        this.error(tikTokErrorTag, errorMessage, stackTrace)
    }

    private val tikTokErrorTag: String = "TikTok Error"

    data object Initialize : TikTokMethod(
        type = TikTokMethodName.INITIALIZE
    ) {
        override fun call(
            context: Context,
            call: MethodCall,
            result: MethodChannel.Result,
            exception: Exception?
        ) {
        try {
            val appId = call.argument<String>("appId")
            val tiktokAppId = call.argument<String>("tiktokId")
            val isDebugMode = call.argument<Boolean>("isDebugMode") ?: false
            val logLevelString = call.argument<String>("logLevel")
            val logLevel = logLevelString?.let { mapLogLevel(it) } ?: TikTokBusinessSdk.LogLevel.INFO
            val options = call.argument<Map<String, Any>>("options") ?: emptyMap()

            if (appId.isNullOrEmpty() || tiktokAppId.isNullOrEmpty()) {
                result.emitError("Parâmetros 'appId' ou 'tiktokId' não fornecidos ou inválidos.")
                return
            }

            val ttConfig = TTConfig(context)
                .setAppId(appId)
                .setTTAppId(tiktokAppId)
                .setLogLevel(logLevel)

            ttConfig = configureAndroidOptions(options, ttConfig)

            if (isDebugMode) {
                ttConfig.openDebugMode()
            }

            TikTokBusinessSdk.initializeSdk(
                ttConfig,
                object : TikTokBusinessSdk.TTInitCallback {
                    override fun success() {
                        result.success("TikTok SDK inicializado com sucesso!")
                    }

                    override fun fail(code: Int, msg: String?) {
                        result.emitError("Falha ao inicializar o TikTok SDK. Código: $code, Mensagem: ${msg ?: "Erro desconhecido"}")
                    }
                })
        } catch (e: Exception) {
            result.emitError("Erro durante a inicialização do TikTok SDK: ${e.message}")
        }
        }
    }

    data object Identify : TikTokMethod(
        type = TikTokMethodName.IDENTIFY
    ) {
        override fun call(
            context: Context,
            call: MethodCall,
            result: MethodChannel.Result,
            exception: Exception?
        ) {
            try {
                val externalId = call.argument<String>("externalId")
                val externalUserName = call.argument<String>("externalUserName")
                val phoneNumber = call.argument<String>("phoneNumber")
                val email = call.argument<String>("email")

                if (externalId.isNullOrEmpty() || externalUserName.isNullOrEmpty() || phoneNumber.isNullOrEmpty() || email.isNullOrEmpty()) {
                    result.emitError("Parâmetros 'externalId' ou 'externalUserName' ou 'phoneNumber' ou 'email' não fornecidos ou inválidos.")
                    return
                }

                TikTokBusinessSdk.identify(
                    externalId, externalUserName, phoneNumber, email
                )

            } catch (e: Exception) {
                result.emitError("Erro durante a inicialização do TikTok SDK: ${e.message}")
            }
        }
    }

    data object SendCustomEvent : TikTokMethod(
        type = TikTokMethodName.SEND_CUSTOM_EVENT
    ) {
        override fun call(
            context: Context,
            call: MethodCall,
            result: MethodChannel.Result,
            exception: Exception?
        ) {
            try {
            val eventName = call.argument<String>("eventName")
            val properties = call.argument<Map<String, Any>>("properties")
            val eventId = call.argument<String>("eventId")

            if (eventName.isNullOrEmpty()) {
                result.emitError("Parâmetro 'eventName' não fornecido ou inválido.")
                return
            }
            
            val eventBuilder = if (eventId.isNullOrEmpty()) {
                    TTBaseEvent.newBuilder(eventName)
                } else {
                    TTBaseEvent.newBuilder(eventName, eventId)
                }

            properties?.forEach { (key, value) ->
                eventBuilder.addProperty(key, value.toString())
            }

            val event = eventBuilder.build()
            TikTokBusinessSdk.trackTTEvent(event)
            result.success("Evento customizado '$eventName' enviado com sucesso!")

            } catch (e: Exception) {
                result.emitError("Erro durante a inicialização do TikTok SDK: ${e.message}")
            }
        }
    }

    data object SendEvent : TikTokMethod(
        type = TikTokMethodName.SEND_EVENT
    ) {
        override fun call(
            context: Context,
            call: MethodCall,
            result: MethodChannel.Result,
            exception: Exception?
        ) {
        try {
            val eventTypeName = call.argument<String>("event_type_name") ?: "none"
            val parameters = call.argument<Map<String, Any>>("parameters") ?: emptyMap()
            val eventId = call.argument<String>("event_id")
            val eventName = call.argument<String>("event_name")

            if (eventName.isNullOrEmpty()) {
                result.emitError("Parâmetro 'event_name' não fornecido ou inválido.")
                return
            }

            val eventBuilder = createEventBuilder(
                eventTypeName = if (eventTypeName == "none") eventName!! else eventTypeName,
                eventId = eventId
            )

            parameters.forEach { (key, value) ->
                eventBuilder.addProperty(key, value)
            }

            val event = eventBuilder.build()
            TikTokBusinessSdk.trackTTEvent(event)

            result.success("Evento '$eventName' enviado com sucesso!")
        } catch (e: Exception) {
            // Retornar erro para o Flutter em caso de falha
            result.emitError("Erro durante o envio do evento: ${e.message}")
        }
        }
    }

    data object Logout : TikTokMethod(
        type = TikTokMethodName.LOGOUT
    ) {
        override fun call(
            context: Context,
            call: MethodCall,
            result: MethodChannel.Result,
            exception: Exception?
        ) {
            try {
                TikTokBusinessSdk.logout()
                result.success("TikTok SDK logout!")
            } catch (e: Exception) {
                result.emitError("Erro durante a inicialização do TikTok SDK: ${e.message}")
            }
        }
    }

    companion object {
        fun getCall(type: String): TikTokMethod? = listOf(
            Initialize,
            Identify,
            SendEvent,
            Logout
        ).firstOrNull { it.type == type }
    }

    private fun mapLogLevel(level: String): TikTokBusinessSdk.LogLevel {
        return when (level) {
            "none" -> TikTokBusinessSdk.LogLevel.NONE
            "info" -> TikTokBusinessSdk.LogLevel.INFO
            "warn" -> TikTokBusinessSdk.LogLevel.WARN
            "debug" -> TikTokBusinessSdk.LogLevel.DEBUG
            "verbose" -> TikTokBusinessSdk.LogLevel.VERBOSE
            else -> TikTokBusinessSdk.LogLevel.NONE
        }
    }

private fun configureAndroidOptions(options: Map<String, Any>, ttConfig: TTConfig): TTConfig {
    if (options["disableAutoStart"] as? Boolean == true) {
        ttConfig.disableAutoStart()
    }
    if (options["disableAutoEvents"] as? Boolean == true) {
        ttConfig.disableAutoEvents()
    }
    if (options["disableInstallLogging"] as? Boolean == true) {
        ttConfig.disableInstallLogging()
    }
    if (options["disableLaunchLogging"] as? Boolean == true) {
        ttConfig.disableLaunchLogging()
    }
    if (options["disableRetentionLogging"] as? Boolean == true) {
        ttConfig.disableRetentionLogging()
    }
    if (options["enableAutoIapTrack"] as? Boolean == true) {
        ttConfig.enableAutoIapTrack()
    }
    if (options["disableAdvertiserIDCollection"] as? Boolean == true) {
        ttConfig.disableAdvertiserIDCollection()
    }
    return ttConfig
}

private fun createEventBuilder(eventTypeName: String, eventId: String?): TTBaseEvent.Builder {
    return when (eventTypeName) {
        "AddToCart" -> if (eventId.isNullOrEmpty()) {
            TTAddToCartEvent.newBuilder()
        } else {
            TTAddToCartEvent.newBuilder(eventId)
        }
        "AddToWishlist" -> if (eventId.isNullOrEmpty()) {
            TTAddToWishlistEvent.newBuilder()
        } else {
            TTAddToWishlistEvent.newBuilder(eventId)
        }
        "Checkout" -> if (eventId.isNullOrEmpty()) {
            TTCheckoutEvent.newBuilder()
        } else {
            TTCheckoutEvent.newBuilder(eventId)
        }
        "Purchase" -> if (eventId.isNullOrEmpty()) {
            TTPurchaseEvent.newBuilder()
        } else {
            TTPurchaseEvent.newBuilder(eventId)
        }
        "ViewContent" -> if (eventId.isNullOrEmpty()) {
            TTViewContentEvent.newBuilder()
        } else {
            TTViewContentEvent.newBuilder(eventId)
        }
        else -> if (eventId.isNullOrEmpty()) {
            TTBaseEvent.newBuilder(eventTypeName)
        } else {
            TTBaseEvent.newBuilder(eventTypeName, eventId)
        }
    }
}


}
