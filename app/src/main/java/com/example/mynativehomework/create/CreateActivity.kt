package com.example.mynativehomework.create

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import androidx.core.app.NavUtils
import androidx.recyclerview.widget.RecyclerView
import com.example.mynativehomework.form.FormOperator
import com.example.mynativehomework.ItemListActivity
import com.example.mynativehomework.R
import com.example.mynativehomework.data.Repository
import com.example.mynativehomework.form.FormRecyclerViewAdapter
import kotlinx.android.synthetic.main.activity_create_activity.*

class CreateActivity : AppCompatActivity() {

    private val formOperator: FormOperator = FormOperator.create()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_create_activity)
        setDisplayHomeAsUp()
        setupRecyclerView(create_form)

        fab.setOnClickListener { view ->
            if (formOperator.modifyRepository(view, Repository::addDuePayment)) {
                runHomeOptionBehaviour()
            }
        }
    }

    // return to the home-page
    private fun setDisplayHomeAsUp() = supportActionBar?.setDisplayHomeAsUpEnabled(true)

    override fun onOptionsItemSelected(item: MenuItem) =
        when (item.itemId) {
            android.R.id.home -> runHomeOptionBehaviour()
            else -> defaultOptionsItemSelected(item)
        }

    private fun runHomeOptionBehaviour(): Boolean {
        NavUtils.navigateUpTo(this, buildNavigateHomeIntent())
        return true
    }

    private fun buildNavigateHomeIntent(): Intent =
        Intent(this, ItemListActivity::class.java)
            .apply { flags = Intent.FLAG_ACTIVITY_CLEAR_TOP }

    private fun defaultOptionsItemSelected(item: MenuItem): Boolean =
        super.onOptionsItemSelected(item)


    //     configure recycler view
    private fun setupRecyclerView(recyclerView: RecyclerView) {
        recyclerView.adapter = FormRecyclerViewAdapter(formOperator.fields)
    }
}