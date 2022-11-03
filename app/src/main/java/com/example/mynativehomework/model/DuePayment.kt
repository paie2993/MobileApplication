package com.example.mynativehomework.model

import java.math.BigDecimal

data class DuePayment(
    val id: Int,
    val totalSum: BigDecimal,
    val reason: String,
    val dueDate: String,
    val paidSum: BigDecimal? = null,
    val type: String? = null,
    val iban: String? = null,
    val address: String? = null,
    val institution: String? = null,
    val status: String? = null
) {

    companion object {
        private var id: Int = 0

        fun create(
            totalSum: BigDecimal,
            reason: String,
            dueDate: String,
            paidSum: BigDecimal? = null,
            type: String? = null,
            iban: String? = null,
            address: String? = null,
            institution: String? = null,
            status: String? = null
        ): DuePayment = DuePayment(
            id = id++,
            totalSum = totalSum,
            reason = reason,
            dueDate = dueDate,
            paidSum = paidSum,
            type = type,
            iban = iban,
            address = address,
            institution = institution,
            status = status
        )

    }

    val numberOfEssentialFields: Int
        get() = 9

    override fun toString(): String =
        "${paidSum ?: 0}$ / $totalSum$    $reason    $dueDate"
}
