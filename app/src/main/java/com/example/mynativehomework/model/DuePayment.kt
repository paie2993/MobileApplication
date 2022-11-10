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
        private var internalId: Int = 0

        fun create(
            id: Int? = null,
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
            id = id ?: internalId++,
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

    override fun equals(other: Any?): Boolean =
        if (other is DuePayment) {
            other.id == this.id
        } else {
            false
        }

    override fun hashCode(): Int = id.hashCode()

    override fun toString(): String =
        "${paidSum ?: 0}$ / $totalSum$    $reason    $dueDate"

    fun getDetails(): String = """
        Total Sum: $totalSum
        Paid Sum: ${paidSum.stringOrNone()}
        Reason: $reason
        Due Date: $dueDate
        Type of payment: ${type.stringOrNone()}
        IBAN: ${iban.stringOrNone()}
        Address: ${address.stringOrNone()}
        Institution: ${institution.stringOrNone()}
        Status: ${status.stringOrNone()}
    """.trimIndent()

    fun sumToString(): String = "${paidSum ?: 0}$ / $totalSum$"

    private fun <T> T?.stringOrNone(): String = this?.toString() ?: "-"
}
