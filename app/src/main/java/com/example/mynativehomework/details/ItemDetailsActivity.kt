package com.example.mynativehomework.details

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import android.view.View
import androidx.core.app.NavUtils
import androidx.fragment.app.Fragment
import com.example.mynativehomework.ItemListActivity
import com.example.mynativehomework.R
import com.example.mynativehomework.update.UpdateActivity
import kotlinx.android.synthetic.main.activity_item_details.*

class ItemDetailsActivity : AppCompatActivity() {

    private val onUpdateClickListener: View.OnClickListener =
        View.OnClickListener(::setUpdateClickListenerActivity)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_item_details)
//        setSupportActionBar(detail_toolbar)

        setUpdateListener()
        setDisplayHomeAsUp()

        savedInstanceState ?: addFragment(buildFragment())
    }

    override fun onOptionsItemSelected(item: MenuItem) =
        when (item.itemId) {
            android.R.id.home -> runHomeOptionBehaviour()
            else -> defaultOptionsItemSelected(item)
        }

    private fun setUpdateClickListenerActivity(view: View) =
        view.context.startActivity(buildUpdateIntent(view))

    private fun buildUpdateIntent(view: View): Intent =
        Intent(view.context, UpdateActivity::class.java)
            .apply { putExtra("item_id", intent.getStringExtra("item_id")) }


    private fun setUpdateListener() = update.setOnClickListener(onUpdateClickListener)

    private fun setDisplayHomeAsUp() = supportActionBar?.setDisplayHomeAsUpEnabled(true)


    private fun buildFragment(): ItemDetailFragment =
        ItemDetailFragment().apply { arguments = buildFragmentBundle() }

    private fun buildFragmentBundle(): Bundle =
        Bundle().apply { putString("item_id", intent.getStringExtra("item_id")) }

    private fun addFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction()
            .add(R.id.item_detail_container, fragment)
            .commit()
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
}