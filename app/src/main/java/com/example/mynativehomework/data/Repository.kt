package com.example.mynativehomework.data

import android.content.Context
import com.example.mynativehomework.R
import com.example.mynativehomework.adapter.RecyclerViewAdapter
import com.example.mynativehomework.model.DuePayment

object Repository {

    private val mutableData: MutableList<DuePayment> = mutableListOf()
    val data: List<DuePayment> = mutableData

    var subscriber: RecyclerViewAdapter? = null

    fun addDuePayment(duePayment: DuePayment) {
        mutableData.add(duePayment)
        subscriber?.notifyItemInserted(mutableData.size - 1)
    }

    fun addAtIndex(duePayment: DuePayment, index: Int) {
        mutableData.add(index, duePayment)
        subscriber?.notifyItemInserted(index)
    }

    fun updateDuePayment(duePayment: DuePayment) {
        val index = data.indexOf(duePayment)
        mutableData[index] = duePayment
        subscriber?.notifyItemChanged(index)
    }

    fun find(id: Int): DuePayment? = data.find { it.id == id }

    fun remove(index: Int) {
        mutableData.removeAt(index)
        subscriber?.notifyItemRemoved(index)
    }

    fun populateRepository(context: Context) {
        mutableData.add(
            DuePayment.create(
                totalSum = context.getString(R.string.payment1_totalSum).toBigDecimal(),
                reason = context.getString(R.string.payment1_reason),
                dueDate = context.getString(R.string.payment1_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                totalSum = context.getString(R.string.payment2_totalSum).toBigDecimal(),
                reason = context.getString(R.string.payment2_reason),
                dueDate = context.getString(R.string.payment2_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                totalSum = context.getString(R.string.payment3_totalSum).toBigDecimal(),
                reason = context.getString(R.string.payment3_reason),
                dueDate = context.getString(R.string.payment3_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                totalSum = context.getString(R.string.payment4_totalSum).toBigDecimal(),
                reason = context.getString(R.string.payment4_reason),
                dueDate = context.getString(R.string.payment4_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                totalSum = context.getString(R.string.payment5_totalSum).toBigDecimal(),
                reason = context.getString(R.string.payment5_reason),
                dueDate = context.getString(R.string.payment5_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                totalSum = context.getString(R.string.payment6_totalSum).toBigDecimal(),
                reason = context.getString(R.string.payment6_reason),
                dueDate = context.getString(R.string.payment6_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                totalSum = context.getString(R.string.payment7_totalSum).toBigDecimal(),
                reason = context.getString(R.string.payment7_reason),
                dueDate = context.getString(R.string.payment7_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                totalSum = context.getString(R.string.payment8_totalSum).toBigDecimal(),
                reason = context.getString(R.string.payment8_reason),
                dueDate = context.getString(R.string.payment8_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                totalSum = context.getString(R.string.payment9_totalSum).toBigDecimal(),
                reason = context.getString(R.string.payment9_reason),
                dueDate = context.getString(R.string.payment9_dueData)
            )
        )
        mutableData.add(
            DuePayment.create(
                totalSum = context.getString(R.string.payment10_totalSum).toBigDecimal(),
                reason = context.getString(R.string.payment10_reason),
                dueDate = context.getString(R.string.payment10_dueData)
            )
        )
    }

}