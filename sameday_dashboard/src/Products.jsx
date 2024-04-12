import React, { useEffect, useMemo, useState } from "react";
import { useTable } from "react-table";
import { Link } from "react-router-dom";
import axios from "axios";
import Swal from "sweetalert2";

const Products = () => {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await axios.get("http://localhost:3000/product");
        if (response.data && Array.isArray(response.data.data)) {
            setProducts(response.data.data);
            console.log(response.data.data);
        } else {
          console.error("Invalid data structure:", response.data);
        }
      } catch (error) {
        console.error("Error fetching products:", error);
      }
    };

    fetchProducts();
  }, []);

const handleDelete = async (productId) => {
  const confirmed = await Swal.fire({
    title: "Are you sure?",
    text: "You won't be able to revert this!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#d33",
    cancelButtonColor: "#3085d6",
    confirmButtonText: "Yes, delete it!",
  });

  if (confirmed.isConfirmed) {
    try {
      await axios.delete(`http://localhost:3000/product/delete/${productId}`);
      setProducts(products.filter((product) => product._id !== productId));
      Swal.fire("Deleted!", "Your product has been deleted.", "success");
    } catch (error) {
      console.error("Error deleting product:", error);
      Swal.fire("Error", "Failed to delete product.", "error");
    }
  }
};



  const columns = useMemo(
    () => [
      { Header: "ID", accessor: "product_id" },
      { Header: "Name", accessor: "product_name" },
      { Header: "Price", accessor: "product_price" },
      { Header: "Image", accessor: "product_image" },
      { Header: "Description", accessor: "product_description" },
      { Header: "Date", accessor: "product_date" },
      { Header: "Category", accessor: "product_category" },
      {
        Header: "Actions",
        Cell: ({ row }) => (
          <div className="flex gap-2">
            {/* <Link
              to={`/products/edit/${row.original._id}`}
              className="btn btn-primary btn-sm rounded bg-orange-400 px-4 text-white"
            >
              Edit
            </Link> */}
                
            <button
              onClick={() => handleDelete(row.original._id)}
              className="btn btn-danger btn-sm rounded bg-red-500 px-4 text-white"
            >
              Delete
            </button>
          </div>
        ),
      },
    ],
    []
  );

  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    rows,
    prepareRow,
  } = useTable({
    columns,
    data: products,
  });

  return (
    <div className="container mx-auto mt-8 p-8">
      <div className="flex justify-between items-center mb-4">
        <h1 className="text-4xl font-semibold text-center">Product Management Dashboard</h1>
        <Link to="/products/create" className="btn btn-primary">
          Create New Product
        </Link>
      </div>

      <table className="table-auto w-full border-collapse border">
        <thead className="bg-gray-800 text-white">
          {headerGroups.map((headerGroup) => (
            <tr {...headerGroup.getHeaderGroupProps()}>
              {headerGroup.headers.map((column) => (
                <th {...column.getHeaderProps()} className="py-2 px-4 border">
                  {column.render("Header")}
                </th>
              ))}
            </tr>
          ))}
        </thead>
        <tbody {...getTableBodyProps()}>
          {rows.map((row) => {
            prepareRow(row);
            return (
              <tr {...row.getRowProps()} className="hover:bg-gray-100">
                {row.cells.map((cell) => (
                  <td {...cell.getCellProps()} className="py-2 px-4 border">
                    {cell.render("Cell")}
                  </td>
                ))}
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
};

export default Products;
