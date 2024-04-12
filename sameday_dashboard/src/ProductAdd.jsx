import React, { useState } from "react";
import axios from "axios";

const ProductNewPage = () => {
  const [product, setProduct] = useState({
    seller_id: "",
    product_name: "",
    product_description: "",
    product_price: 0,
    product_category: "",
    product_quantity: 0,
    product_image: "",
    product_date: new Date(),
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setProduct((prevProduct) => ({
      ...prevProduct,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post("http://localhost:3000/product/create", product);
      console.log(response.data); // Log the response from the backend
      // Reset the form after successful submission
      setProduct({
        seller_id: "",
        product_name: "",
        product_description: "",
        product_price: 0,
        product_category: "",
        product_quantity: 0,
        product_image: "",
        product_date: new Date(),
      });
      //NAVIGATE TO PRODUCT
      window.location.replace("/");
    } catch (error) {
      console.error("Error adding product:", error);
    }
  };

  return (
    <div className="container mx-auto mt-8 p-8">
      <h2 className="text-4xl font-semibold mb-4">Add Product</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-4">
          <label className="block text-lg font-medium mb-1">Seller ID</label>
          <input type="text" name="seller_id" value={product.seller_id} onChange={handleChange} className="input text-lg w-full border " />
        </div>
        <div className="mb-4">
          <label className="block text-lg font-medium mb-1">Name</label>
          <input type="text" name="product_name" value={product.product_name} onChange={handleChange} className="input text-lg w-full border" />
        </div>
        <div className="mb-4">
          <label className="block text-lg font-medium mb-1">Description</label>
          <textarea name="product_description" value={product.product_description} onChange={handleChange} className="input text-lg w-full border" />
        </div>
        <div className="mb-4">
          <label className="block text-lg font-medium mb-1">Price</label>
          <input type="number" name="product_price" value={product.product_price} onChange={handleChange} className="input text-lg w-full border" />
        </div>
        <div className="mb-4">
          <label className="block text-lg font-medium mb-1">Category</label>
          <input type="text" name="product_category" value={product.product_category} onChange={handleChange} className="input text-lg w-full border" />
        </div>
        <div className="mb-4">
          <label className="block text-lg font-medium mb-1">Image</label>
          <input type="text" name="product_image" value={product.product_image} onChange={handleChange} className="input text-lg w-full border" />
        </div>
        <div className="mb-4">
          <label className="block text-lg font-medium mb-1">Quantity</label>
          <input type="number" name="product_quantity" value={product.product_quantity} onChange={handleChange} className="input text-lg w-full border" />
        </div>
        <button type="submit" className="btn btn-primary rounded text-2xl bg-black text-white px-4 w-full">Add Product</button>
      </form>
    </div>
  );
};

export default ProductNewPage;
