import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";

const ProductEditPage = () => {
  const { id } = useParams();
  const [product, setProduct] = useState({
    name: "",
    description: "",
    price: 0,
    category: "",
    quantity: 0,
  });
  useEffect(() => {
    const fetchProduct = async () => {
      try {
        const response = await axios.get(`http://localhost:8000/product/${id}`);
        if (response.data && response.data.data) {
          const { name, description, price, category, quantity } = response.data.data[0];
          setProduct({ name, description, price, category, quantity });
        } else {
          console.error("Invalid product data structure:", response.data);
        }
      } catch (error) {
        console.error("Error fetching product:", error);
      }
    };

    fetchProduct();
  }, [id]);

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
      await axios.put(`http://localhost:8000/products/${id}`, product);
      // Handle successful product update
    } catch (error) {
      console.error("Error updating product:", error);
    }
  };

  return (
    <div className="container mx-auto mt-8 p-8">
      <h2 className="text-4xl font-semibold mb-4">Edit Product</h2>
      <form onSubmit={handleSubmit}>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div>
            <label className="block text-lg font-medium mb-1">Name</label>
            <input
              type="text"
              name="name"
              value={product.name}
              onChange={handleChange}
              className="input w-full"
            />
          </div>
          <div>
            <label className="block text-lg font-medium mb-1">Description</label>
            <textarea
              name="description"
              value={product.description}
              onChange={handleChange}
              className="input w-full"
            />
          </div>
          <div>
            <label className="block text-lg font-medium mb-1">Price</label>
            <input
              type="number"
              name="price"
              value={product.price}
              onChange={handleChange}
              className="input w-full"
            />
          </div>
          <div>
            <label className="block text-lg font-medium mb-1">Category</label>
            <input
              type="text"
              name="category"
              value={product.category}
              onChange={handleChange}
              className="input w-full"
            />
          </div>
          <div>
            <label className="block text-lg font-medium mb-1">Quantity</label>
            <input
              type="number"
              name="quantity"
              value={product.quantity}
              onChange={handleChange}
              className="input w-full"
            />
          </div>
        </div>
        <button
          type="submit"
          className="btn btn-primary rounded text-2xl bg-orange-400 text-white px-4 mt-4"
        >
          Update Product
        </button>
      </form>
    </div>
  );
};

export default ProductEditPage;
