package com.example.mynativehomework

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.RecyclerView
import com.example.mynativehomework.adapter.RecyclerViewAdapter
import kotlinx.android.synthetic.main.activity_due_payment_list.*
import kotlinx.android.synthetic.main.recycler_view_list.*

class ItemListActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_due_payment_list)

        Log.i("information", "onCreate called")

        setSupportActionBar(toolbar)
        toolbar.title = title

        setupRecyclerView(recycler_view_list)
    }

    private fun setupRecyclerView(recyclerView: RecyclerView) {
        recyclerView.adapter = RecyclerViewAdapter(this)
    }
}