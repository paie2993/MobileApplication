package com.example.mynativehomework.form

import android.view.View
import com.example.mynativehomework.model.DuePayment
import com.google.android.material.snackbar.Snackbar

class FormOperator(
    val duePaymentId: Int?,
    val totalSum: Field,
    val paidSum: Field,
    val reason: Field,
    val dueDate: Field,
    val iban: Field,
    val type: Field,
    val address: Field,
    val institution: Field,
    val status: Field
) {

    val fields: List<Field>
        get() = listOf(totalSum, paidSum, reason, dueDate, iban, type, address, institution, status)

    companion object {
        private const val numericRegex: String = "^[1-9][0-9]*.?[0-9]*$"
        private const val stringRegex: String = "^.+$"

        fun create(duePayment: DuePayment? = null): FormOperator =
            FormOperator(
                duePaymentId = duePayment?.id,
                totalSum = Field(
                    "Total Sum",
                    duePayment?.totalSum?.toString() ?: "",
                    numericRegex,
                    false
                ),
                paidSum = Field(
                    "Paid Sum",
                    duePayment?.paidSum?.toString() ?: "",
                    numericRegex,
                    true
                ),
                reason = Field("Reason for payment", duePayment?.reason ?: "", stringRegex, false),
                dueDate = Field("Due date", duePayment?.dueDate ?: "", stringRegex, false),
                iban = Field("IBAN", duePayment?.iban ?: "", stringRegex, true),
                type = Field("Type", duePayment?.type ?: "", stringRegex, true),
                address = Field("Address", duePayment?.address ?: "", stringRegex, true),
                institution = Field(
                    "Institution",
                    duePayment?.institution ?: "",
                    stringRegex,
                    true
                ),
                status = Field("Status", duePayment?.status ?: "", stringRegex, true),
            )
    }

    fun modifyRepository(view: View, operation: (DuePayment) -> Unit): Boolean {
        if (!validateUserInput(view)) {
            return false
        }

        val duePayment = DuePayment.create(
            id = duePaymentId,
            totalSum = totalSum.value.toBigDecimal(),
            paidSum = paidSum.value.takeIf { it.isNotEmpty() }?.toBigDecimal(),
            reason = reason.value,
            dueDate = dueDate.value,
            iban = iban.value,
            type = type.value,
            address = address.value,
            institution = institution.value,
            status = status.value
        )

        operation(duePayment)
        return true
    }


    private fun validateUserInput(view: View): Boolean {
        if (!validateByRegex(view)) {
            return false
        }
        if (!validateSums(view)) {
            return false
        }
        return true
    }

    private fun validateByRegex(view: View): Boolean =
        fields.asSequence()
            .map { validateSpecificInput(view, it) }
            .reduce { acc, current -> acc && current }


    private fun validateSpecificInput(
        view: View,
        field: Field
    ): Boolean {
        if (field.value.isEmpty()) {
            if (!field.optional) {
                Snackbar.make(view, "\"${field.label}\" is mandatory.", Snackbar.LENGTH_LONG).show()
                return false
            }
            return true
        }
        val regex = Regex(field.validationRegex)
        if (!field.value.matches(regex)) {
            Snackbar.make(view, "\"${field.label}\" invalid value.", Snackbar.LENGTH_LONG).show()
            return false
        }
        return true
    }

    private fun validateSums(view: View): Boolean {
        if (!validateSpecificInput(view, totalSum) || !validateSpecificInput(view, paidSum)) {
            return false
        }
        if (paidSum.value.isEmpty()) {
            return true
        }
        val totalSumNumber = totalSum.value.toBigDecimal()
        val paidSumNumber = paidSum.value.toBigDecimal()

        return if (paidSumNumber > totalSumNumber) {
            Snackbar.make(view, "Paid Sum can't be greater than Total Sum", Snackbar.LENGTH_LONG)
                .show()
            false
        } else {
            true
        }
    }
}