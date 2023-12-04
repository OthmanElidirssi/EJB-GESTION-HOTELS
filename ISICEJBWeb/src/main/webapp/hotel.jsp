<%@page import="entities.Hotel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Hotel Page</title>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 20px;
	background-color: #f4f4f4;
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

form input, form select {
	width: 50em;
	padding: 8px;
	margin-bottom: 16px;
}

#button {
	cursor: pointer;
	padding: 12px 30px;
	font-size: 16px;
	border: none;
	border-radius: 8px;
	background-color: #4CAF50;
	color: white;
	transition: background-color 0.3s;
	display: block;
}

#button2 {
	cursor: pointer;
	padding: 12px 30px;
	font-size: 16px;
	border: none;
	border-radius: 8px;
	background-color: orange;
	color: white;
	transition: background-color 0.3s;
	display: block;
}

#button:hover {
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

	<form action="HotelController" method="post">
		<h1>Add an hotel</h1>
		<input type="hidden" id="selectedHotelId" name="selectedHotelId"
			value=""> <label for="nom">Name :</label> <input type="text"
			id="nom" name="nom" required> <label for="adresse">Adress
			:</label> <input type="text" id="adresse" name="adresse" required> <label
			for="telephone">Phone :</label> <input type="text" id="telephone"
			name="telephone" required> <label for="ville">City :</label>
		<select id="ville" name="ville" required>
			<option value="" disabled selected>Select a City</option>

			<c:forEach items="${villes}" var="v">
				<option value="${v.id}">${v.nom}</option>
			</c:forEach>
		</select>
		<button type="submit" id="button">Add</button>
	</form>

	<h1>List of hotels</h1>
	<table id="hotel">
		<thead>
			<tr>
				<th>Nº</th>
				<th>Name</th>
				<th>Adress</th>
				<th>Phone</th>
				<th>City</th>
				<th>Delete</th>
				<th>Update</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${hotels}" var="hotel">
				<tr>
					<td>${hotel.id}</td>
					<td>${hotel.nom}</td>
					<td>${hotel.adresse}</td>
					<td>${hotel.telephone}</td>
					<td>${hotel.ville.nom}</td>
					<td>
						<button class="delete" id="button"
							onclick="deleteh(${hotel.id})">Delete</button>
					</td>
					<td>
						<button class="modify" id="button2"
							onclick="modifyh(${hotel.id})">Update</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<script>
    $(document).ready(function() {
        $('#hotel').DataTable({
           
        });
    });

    function deleteh(hotelId) {
        if (confirm('You want to delete this hotel ?')) {
            $.ajax({
                type: 'POST',
                url: 'HotelController?action=delete&hotelId=' + hotelId,
                success: function (data) {
                    var table = $('#hotel').DataTable();
                    var row = table.row($('#hotel').find('tr:has(td:contains(' + hotelId + '))'));
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
