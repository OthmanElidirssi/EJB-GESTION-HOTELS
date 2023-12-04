<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Ville Page</title>

  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      background-color: #f4f4f4;
    }

    h1 {
      color: #333;
    }

    form {
      margin-bottom: 20px;
      padding: 20px;
      border-radius: 8px;
      box-sizing: border-box;
    }

    form label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
    }

    form input {
      width: 100%;
      padding: 8px;
      margin-bottom: 16px;
      box-sizing: border-box;
    }

    #button {
      cursor: pointer;
      padding: 12px 20px;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      background-color: #4CAF50;
      color: white;
      transition: background-color 0.3s;
    }
        
     #button1 {
      cursor: pointer;
      padding: 12px 20px;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      background-color: orange;
      color: white;
      transition: background-color 0.3s;
    }

    .button:hover {
      background-color: #45a049;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      margin-top: 20px;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: left;
    }

    th {
      background-color: #f2f2f2;
    }
  </style>
</head>
<body>

  <form action="VilleController" method="post">
    <h1>Add a city</h1>
    <label for="ville" style="font-weight: bold;">Name :</label>
    <input type="text" id="ville" name="ville" style = "width:30em;"required />
    <button type="submit" id="button">Add</button>
  </form>

  <h1>List of cities :</h1>

  <table id="villeTable">
    <thead>
      <tr>
        <th>Nº</th>
        <th>Name</th>
        <th>Delete</th>
        <th>Update</th>
      </tr>
    </thead>
    <tbody>    <c:forEach items="${villes}" var="v">
				<tr>
					<td>${v.id}</td>
					<td>${v.nom}</td>
					<td>
						<button class="delete" id="button" onclick="deleteV(${v.id})">Delete</button>
					</td>
					<td>
						<button class="modify"  id="button1" onclick="modifyV${v.id})">Update</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<script>
        $(document).ready(function () {
            $('#ville').DataTable({
               
        });

        function deleteV(villeId) {
            if (confirm('You want to delete this city?')) {
                $.ajax({
                    type: 'POST',
                    url: 'VilleController?action=delete&villeId=' + villeId,
                    success: function (data) {
                            var table = $('#ville').DataTable();
                            var row = table.row($('#ville').find('tr:has(td:contains(' + villeId + '))'));
                            row.remove().draw();
                       
                    },
                    error: function (xhr, status, error) {
                    }
                });
            }
        }
      


    </script>

</body>
</html>
