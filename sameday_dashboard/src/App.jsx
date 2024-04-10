import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Products from './Products';
import ProductEditPage from './ProductEdit';
//css
import './App.css'
import ProductNewPage from './ProductAdd';


function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <Router>
        <Routes>
          


          {/* <Route exact path="/" element={<div>Hello</div>} /> */}
                        <Route path="/" element={<Products />} />
          <Route path="/products/edit/:id" element={<ProductEditPage />} />
          <Route path="/products/create" element={<ProductNewPage/>} />

          
        </Routes>
      </Router>
      
     
    </>
  )
}

export default App
