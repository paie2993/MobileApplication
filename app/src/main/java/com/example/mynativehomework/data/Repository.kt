package com.example.mynativehomework.data

import android.content.Context
import com.example.mynativehomework.R
import com.example.mynativehomework.model.DuePayment

object Repository {

    private val mutableData: MutableList<DuePayment> = mutableListOf()
    val data: List<DuePayment> = mutableData

    fun populateRepository(context: Context) {
        mutableData.add(
            DuePayment.create(
                context.getString(R.string.payment1_totalSum).toBigDecimal(),
                context.getString(R.string.payment1_reason),
                context.getString(R.string.payment1_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                context.getString(R.string.payment2_totalSum).toBigDecimal(),
                context.getString(R.string.payment2_reason),
                context.getString(R.string.payment2_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                context.getString(R.string.payment3_totalSum).toBigDecimal(),
                context.getString(R.string.payment3_reason),
                context.getString(R.string.payment3_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                context.getString(R.string.payment4_totalSum).toBigDecimal(),
                context.getString(R.string.payment4_reason),
                context.getString(R.string.payment4_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                context.getString(R.string.payment5_totalSum).toBigDecimal(),
                context.getString(R.string.payment5_reason),
                context.getString(R.string.payment5_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                context.getString(R.string.payment6_totalSum).toBigDecimal(),
                context.getString(R.string.payment6_reason),
                context.getString(R.string.payment6_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                context.getString(R.string.payment7_totalSum).toBigDecimal(),
                context.getString(R.string.payment7_reason),
                context.getString(R.string.payment7_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                context.getString(R.string.payment8_totalSum).toBigDecimal(),
                context.getString(R.string.payment8_reason),
                context.getString(R.string.payment8_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                context.getString(R.string.payment9_totalSum).toBigDecimal(),
                context.getString(R.string.payment9_reason),
                context.getString(R.string.payment9_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                context.getString(R.string.payment10_totalSum).toBigDecimal(),
                context.getString(R.string.payment10_reason),
                context.getString(R.string.payment10_dueData)
            )
        )
    }

}